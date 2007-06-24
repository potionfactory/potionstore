# SOAP4R - WSDL literal mapping registry.
# Copyright (C) 2004, 2005  NAKAMURA, Hiroshi <nahi@ruby-lang.org>.

# This program is copyrighted free software by NAKAMURA, Hiroshi.  You can
# redistribute it and/or modify it under the same terms of Ruby's license;
# either the dual license version in 2003, or any later version.


require 'soap/baseData'
require 'soap/mapping/mapping'
require 'soap/mapping/typeMap'
require 'xsd/codegen/gensupport'
require 'xsd/namedelements'


module SOAP
module Mapping


class WSDLLiteralRegistry < Registry
  attr_reader :definedelements
  attr_reader :definedtypes
  attr_accessor :excn_handler_obj2soap
  attr_accessor :excn_handler_soap2obj

  def initialize(definedtypes = XSD::NamedElements::Empty,
      definedelements = XSD::NamedElements::Empty)
    @definedtypes = definedtypes
    @definedelements = definedelements
    @excn_handler_obj2soap = nil
    @excn_handler_soap2obj = nil
    @schema_element_cache = {}
    @schema_attribute_cache = {}
  end

  def obj2soap(obj, qname)
    soap_obj = nil
    if obj.is_a?(SOAPElement)
      soap_obj = obj
    elsif eledef = @definedelements[qname]
      soap_obj = obj2elesoap(obj, eledef)
    elsif type = @definedtypes[qname]
      soap_obj = obj2typesoap(obj, type, true)
    else
      soap_obj = any2soap(obj, qname)
    end
    return soap_obj if soap_obj
    if @excn_handler_obj2soap
      soap_obj = @excn_handler_obj2soap.call(obj) { |yield_obj|
        Mapping.obj2soap(yield_obj, nil, nil, MAPPING_OPT)
      }
      return soap_obj if soap_obj
    end
    raise MappingError.new("cannot map #{obj.class.name} as #{qname}")
  end

  # node should be a SOAPElement
  def soap2obj(node, obj_class = nil)
    # obj_class is given when rpc/literal service.  but ignored for now.
    begin
      return any2obj(node)
    rescue MappingError
    end
    if @excn_handler_soap2obj
      begin
        return @excn_handler_soap2obj.call(node) { |yield_node|
	    Mapping.soap2obj(yield_node, nil, nil, MAPPING_OPT)
	  }
      rescue Exception
      end
    end
    if node.respond_to?(:type)
      raise MappingError.new("cannot map #{node.type.name} to Ruby object")
    else
      raise MappingError.new("cannot map #{node.elename.name} to Ruby object")
    end
  end

private

  MAPPING_OPT = { :no_reference => true }

  def obj2elesoap(obj, eledef)
    ele = nil
    qualified = (eledef.elementform == 'qualified')
    if eledef.type
      if type = @definedtypes[eledef.type]
        ele = obj2typesoap(obj, type, qualified)
      elsif type = TypeMap[eledef.type]
        ele = base2soap(obj, type)
      else
        raise MappingError.new("cannot find type #{eledef.type}")
      end
    elsif eledef.local_complextype
      ele = obj2typesoap(obj, eledef.local_complextype, qualified)
    elsif eledef.local_simpletype
      ele = obj2typesoap(obj, eledef.local_simpletype, qualified)
    else
      raise MappingError.new('illegal schema?')
    end
    ele.elename = eledef.name
    ele
  end

  def obj2typesoap(obj, type, qualified)
    ele = nil
    if type.is_a?(::WSDL::XMLSchema::SimpleType)
      ele = simpleobj2soap(obj, type)
    elsif type.simplecontent
      ele = simpleobj2soap(obj, type.simplecontent)
    else
      ele = complexobj2soap(obj, type, qualified)
    end
    add_attributes2soap(obj, ele)
    ele
  end

  def simpleobj2soap(obj, type)
    type.check_lexical_format(obj)
    return SOAPNil.new if obj.nil?      # TODO: check nillable.
    if type.base
      ele = base2soap(obj, TypeMap[type.base])
    elsif type.list
      ele = base2soap(obj.join(" "), SOAP::SOAPString)
    else
      raise MappingError.new("unsupported simpleType: #{type}")
    end
    ele
  end

  def complexobj2soap(obj, type, qualified)
    ele = SOAPElement.new(type.name)
    ele.qualified = qualified
    if type.choice?
      complexobj2choicesoap(obj, ele, type)
    else
      complexobj2sequencesoap(obj, ele, type)
    end
  end

  def complexobj2sequencesoap(obj, ele, type)
    elements = type.elements
    any = nil
    if type.have_any?
      any = scan_any(obj, elements)
    end
    elements.each do |child_ele|
      case child_ele
      when WSDL::XMLSchema::Any
        if any
          SOAPElement.from_objs(any).each do |child|
            ele.add(child)
          end
        end
      when WSDL::XMLSchema::Element
        complexobj2soapchildren(obj, ele, child_ele)
      when WSDL::XMLSchema::Sequence
        complexobj2sequencesoap(obj, child_ele, type)
      when WSDL::XMLSchema::Choice
        complexobj2choicesoap(obj, child_ele, type)
      else
        raise MappingError.new("unknown type: #{child_ele}")
      end
    end
    ele
  end

  def complexobj2choicesoap(obj, ele, type)
    elements = type.elements
    any = nil
    if type.have_any?
      raise MappingError.new(
        "<any/> in <choice/> is not supported: #{ele.name.name}")
    end
    elements.each do |child_ele|
      break if complexobj2soapchildren(obj, ele, child_ele, true)
    end
    ele
  end

  def complexobj2soapchildren(obj, ele, child_ele, allow_nil_value = false)
    if child_ele.map_as_array?
      complexobj2soapchildren_array(obj, ele, child_ele, allow_nil_value)
    else
      complexobj2soapchildren_single(obj, ele, child_ele, allow_nil_value)
    end
  end

  def complexobj2soapchildren_array(obj, ele, child_ele, allow_nil_value)
    child = Mapping.get_attribute(obj, child_ele.name.name)
    if child.nil? and obj.respond_to?(:each)
      child = obj
    end
    if child.nil?
      return false if allow_nil_value
      if child_soap = nil2soap(child_ele)
        ele.add(child_soap)
        return true
      else
        return false
      end
    end
    unless child.respond_to?(:each)
      return false
    end
    child.each do |item|
      if item.is_a?(SOAPElement)
        ele.add(item)
      else
        child_soap = obj2elesoap(item, child_ele)
        ele.add(child_soap)
      end
    end
    true
  end

  def complexobj2soapchildren_single(obj, ele, child_ele, allow_nil_value)
    child = Mapping.get_attribute(obj, child_ele.name.name)
    case child
    when NilClass
      return false if allow_nil_value
      if child_soap = nil2soap(child_ele)
        ele.add(child_soap)
        true
      else
        false
      end
    when SOAPElement
      ele.add(child)
      true
    else
      child_soap = obj2elesoap(child, child_ele)
      ele.add(child_soap)
      true
    end
  end

  def scan_any(obj, elements)
    if obj.respond_to?(:__xmlele_any)
      obj.__xmlele_any
    else
      any = Mapping.get_attributes(obj)
      if elements
        elements.each do |child_ele|
          child = Mapping.get_attribute(obj, child_ele.name.name)
          if k = any.key(child)
            any.delete(k)
          end
        end
      end
      any
    end
  end

  def nil2soap(ele)
    if ele.nillable
      obj2elesoap(nil, ele)     # add an empty element
    elsif Integer(ele.minoccurs) == 0
      nil       # intends no element
    else
      raise MappingError.new("nil not allowed: #{ele.name.name}")
    end
  end

  def any2soap(obj, qname)
    ele = nil
    if obj.class.class_variables.include?('@@schema_element')
      ele = stubobj2soap(obj, qname)
    elsif obj.is_a?(SOAP::Mapping::Object)
      ele = mappingobj2soap(obj, qname)
    elsif obj.is_a?(Hash)
      ele = SOAPElement.from_obj(obj)
      ele.elename = qname
    elsif obj.is_a?(Array)
      # treat as a list of simpletype
      ele = SOAPElement.new(qname, obj.join(" "))
    elsif obj.is_a?(XSD::QName)
      ele = SOAPElement.new(qname)
      ele.text = obj
    else
      # expected to be a basetype or an anyType.
      # SOAPStruct, etc. is used instead of SOAPElement.
      begin
        ele = Mapping.obj2soap(obj, nil, nil, MAPPING_OPT)
        ele.elename = qname
      rescue MappingError
        ele = SOAPElement.new(qname, obj.to_s)
      end
    end
    add_attributes2soap(obj, ele)
    ele
  end

  def stubobj2soap(obj, qname)
    ele = SOAPElement.new(qname)
    ele.qualified =
      (obj.class.class_variables.include?('@@schema_qualified') and
      obj.class.class_eval('@@schema_qualified'))
    add_elements2soap(obj, ele)
    ele
  end

  def mappingobj2soap(obj, qname)
    ele = SOAPElement.new(qname)
    obj.__xmlele.each do |key, value|
      if value.is_a?(::Array)
        value.each do |item|
          ele.add(obj2soap(item, key))
        end
      else
        ele.add(obj2soap(value, key))
      end
    end
    ele
  end

  def add_elements2soap(obj, ele)
    definition = schema_element_definition(obj.class)
    any = nil
    if definition.have_any?
      any = scan_any(obj, definition.elements)
    end
    definition.elements.each do |eledef|
      if eledef.elename == XSD::AnyTypeName
        if any
          SOAPElement.from_objs(any).each do |child|
            ele.add(child)
          end
        end
      elsif child = Mapping.get_attribute(obj, eledef.elename.name)
        if eledef.as_array?
          child.each do |item|
            ele.add(obj2soap(item, eledef.elename))
          end
        else
          ele.add(obj2soap(child, eledef.elename))
        end
      elsif obj.respond_to?(:each) and eledef.as_array?
        obj.each do |item|
          ele.add(obj2soap(item, eledef.elename))
        end
      end
    end
  end
  
  def add_attributes2soap(obj, ele)
    attributes = schema_attribute_definition(obj.class)
    if attributes
      attributes.each do |qname, param|
        attr = obj.__send__(
          XSD::CodeGen::GenSupport.safemethodname('xmlattr_' + qname.name))
        ele.extraattr[qname] = attr
      end
    elsif obj.respond_to?(:__xmlattr)
      obj.__xmlattr.each do |key, value|
        ele.extraattr[key] = value
      end
    end
  end

  def base2soap(obj, type)
    soap_obj = nil
    if type <= XSD::XSDString
      str = XSD::Charset.encoding_conv(obj.to_s,
        Thread.current[:SOAPExternalCES], XSD::Charset.encoding)
      soap_obj = type.new(str)
    else
      soap_obj = type.new(obj)
    end
    soap_obj
  end

  def any2obj(node, obj_class = nil)
    unless obj_class
      typestr = XSD::CodeGen::GenSupport.safeconstname(node.elename.name)
      obj_class = Mapping.class_from_name(typestr)
    end
    if node.is_a?(SOAPElement) or node.is_a?(SOAPStruct)
      if obj_class and obj_class.class_variables.include?('@@schema_element')
        elesoap2stubobj(node, obj_class)
      else
        # SOAPArray for literal?
        elesoap2plainobj(node)
      end
    else
      obj = Mapping.soap2obj(node, nil, obj_class, MAPPING_OPT)
      add_attributes2obj(node, obj)
      obj
    end
  end

  def elesoap2stubobj(node, obj_class)
    obj = Mapping.create_empty_object(obj_class)
    add_elesoap2stubobj(node, obj)
    add_attributes2stubobj(node, obj)
    obj
  end

  def elesoap2plainobj(node)
    obj = anytype2obj(node)
    add_elesoap2plainobj(node, obj)
    add_attributes2obj(node, obj)
    obj
  end

  def anytype2obj(node)
    if node.is_a?(::SOAP::SOAPBasetype)
      return node.data
    end
    klass = ::SOAP::Mapping::Object
    obj = klass.new
    obj
  end

  def add_elesoap2stubobj(node, obj)
    definition = schema_element_definition(obj.class)
    vars = {}
    node.each do |name, value|
      item = definition.elements.find { |k, v| k.elename.name == name }
      if item and item.type
        if klass = Mapping.class_from_name(item.type)
          # klass must be a SOAPBasetype or a class
          if klass.ancestors.include?(::SOAP::SOAPBasetype)
            if value.respond_to?(:data)
              child = klass.new(value.data).data
            else
              child = klass.new(nil).data
            end
          else
            child = any2obj(value, klass)
          end
        elsif klass = Mapping.module_from_name(item.type)
          # simpletype
          if value.respond_to?(:data)
            child = value.data
          else
            raise MappingError.new("cannot map to a module value: #{item.type}")
          end
        else
          raise MappingError.new("unknown class/module: #{item.type}")
        end
      else      # untyped element is treated as anyType.
        child = any2obj(value)
      end
      if item and item.as_array?
        (vars[name] ||= []) << child
      else
        vars[name] = child
      end
    end
    if obj.is_a?(::Array)
      vars.values.flatten.each do |item|
        obj << item
      end
    else
      Mapping.set_attributes(obj, vars)
    end
  end

  def add_attributes2stubobj(node, obj)
    if attributes = schema_attribute_definition(obj.class)
      define_xmlattr(obj)
      attributes.each do |qname, class_name|
        attr = node.extraattr[qname]
        next if attr.nil? or attr.empty?
        klass = Mapping.class_from_name(class_name)
        if klass.ancestors.include?(::SOAP::SOAPBasetype)
          child = klass.new(attr).data
        else
          child = attr
        end
        obj.__xmlattr[qname] = child
        define_xmlattr_accessor(obj, qname)
      end
    end
  end

  def add_elesoap2plainobj(node, obj)
    node.each do |name, value|
      obj.__add_xmlele_value(value.elename, any2obj(value))
    end
  end

  def add_attributes2obj(node, obj)
    return if node.extraattr.empty?
    define_xmlattr(obj)
    node.extraattr.each do |qname, value|
      obj.__xmlattr[qname] = value
      define_xmlattr_accessor(obj, qname)
    end
  end

  if RUBY_VERSION > "1.7.0"
    def define_xmlattr_accessor(obj, qname)
      name = XSD::CodeGen::GenSupport.safemethodname('xmlattr_' + qname.name)
      Mapping.define_attr_accessor(obj, name,
        proc { @__xmlattr[qname] },
        proc { |value| @__xmlattr[qname] = value })
    end
  else
    def define_xmlattr_accessor(obj, qname)
      name = XSD::CodeGen::GenSupport.safemethodname('xmlattr_' + qname.name)
      obj.instance_eval <<-EOS
        def #{name}
          @__xmlattr[#{qname.dump}]
        end

        def #{name}=(value)
          @__xmlattr[#{qname.dump}] = value
        end
      EOS
    end
  end

  if RUBY_VERSION > "1.7.0"
    def define_xmlattr(obj)
      obj.instance_variable_set('@__xmlattr', {})
      unless obj.respond_to?(:__xmlattr)
        Mapping.define_attr_accessor(obj, :__xmlattr, proc { @__xmlattr })
      end
    end
  else
    def define_xmlattr(obj)
      obj.instance_variable_set('@__xmlattr', {})
      unless obj.respond_to?(:__xmlattr)
        obj.instance_eval <<-EOS
          def __xmlattr
            @__xmlattr
          end
        EOS
      end
    end
  end

  # it caches @@schema_element.  this means that @@schema_element must not be
  # changed while a lifetime of a WSDLLiteralRegistry.
  def schema_element_definition(klass)
    @schema_element_cache[klass] ||= Mapping.schema_element_definition(klass)
  end

  def schema_attribute_definition(klass)
    @schema_attribute_cache[klass] ||=
      Mapping.schema_attribute_definition(klass)
  end
end


end
end
