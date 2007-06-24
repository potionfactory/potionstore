# WSDL4R - Creating class definition from WSDL
# Copyright (C) 2002, 2003, 2004, 2005  NAKAMURA, Hiroshi <nahi@ruby-lang.org>.

# This program is copyrighted free software by NAKAMURA, Hiroshi.  You can
# redistribute it and/or modify it under the same terms of Ruby's license;
# either the dual license version in 2003, or any later version.


require 'wsdl/data'
require 'wsdl/soap/classDefCreatorSupport'
require 'xsd/codegen'


module WSDL
module SOAP


class ClassDefCreator
  include ClassDefCreatorSupport
  include XSD::CodeGen

  def initialize(definitions)
    @elements = definitions.collect_elements
    @elements.uniq!
    @attributes = definitions.collect_attributes
    @attributes.uniq!
    @simpletypes = definitions.collect_simpletypes
    @simpletypes.uniq!
    @complextypes = definitions.collect_complextypes
    @complextypes.uniq!
    @faulttypes = nil
    if definitions.respond_to?(:collect_faulttypes)
      @faulttypes = definitions.collect_faulttypes
    end
  end

  def dump(type = nil)
    result = "require 'xsd/qname'\n"
    if type
      result = dump_classdef(type.name, type)
    else
      str = dump_element
      unless str.empty?
        result << "\n" unless result.empty?
        result << str
      end
      str = dump_attribute
      unless str.empty?
        result << "\n" unless result.empty?
        result << str
      end
      str = dump_complextype
      unless str.empty?
        result << "\n" unless result.empty?
        result << str
      end
      str = dump_simpletype
      unless str.empty?
        result << "\n" unless result.empty?
        result << str
      end
    end
    result
  end

private

  def dump_element
    @elements.collect { |ele|
      if ele.local_complextype
        qualified = ele.elementform == 'qualified'
        dump_complextypedef(ele.name, ele.local_complextype, qualified)
      elsif ele.local_simpletype
        dump_simpletypedef(ele.name, ele.local_simpletype)
      else
        nil
      end
    }.compact.join("\n")
  end

  def dump_attribute
    @attributes.collect { |attr|
      if attr.local_simpletype
        dump_simpletypedef(attr.name, attr.local_simpletype)
      end
    }.compact.join("\n")
  end

  def dump_simpletype
    @simpletypes.collect { |type|
      dump_simpletypedef(type.name, type)
    }.compact.join("\n")
  end

  def dump_complextype
    @complextypes.collect { |type|
      dump_complextypedef(type.name, type)
    }.compact.join("\n")
  end

  def dump_simpletypedef(qname, simpletype)
    if simpletype.restriction
      dump_simpletypedef_restriction(qname, simpletype.restriction)
    elsif simpletype.list
      dump_simpletypedef_list(qname, simpletype.list)
    else
      raise RuntimeError.new("unknown kind of simpletype: #{simpletype}")
    end
  end

  def dump_simpletypedef_restriction(qname, restriction)
    if restriction.enumeration.empty?
      # not supported.  minlength?
      return nil
    end
    c = ModuleDef.new(create_class_name(qname))
    c.comment = "#{qname}"
    define_enum_restriction(c, restriction.enumeration)
    c.dump
  end

  def dump_simpletypedef_list(qname, list)
    c = ClassDef.new(create_class_name(qname), '::Array')
    c.comment = "#{qname}"
    if simpletype = list.local_simpletype
      if simpletype.restriction.nil?
        raise RuntimeError.new(
          "unknown kind of simpletype: #{simpletype}")
      end
      define_enum_restriction(c, simpletype.restriction.enumeration)
      c.comment << "\n  contains list of #{create_class_name(qname)}::*"
    elsif list.itemtype
      c.comment << "\n  contains list of #{create_class_name(list.itemtype)}::*"
    else
      raise RuntimeError.new("unknown kind of list: #{list}")
    end
    c.dump
  end

  def define_enum_restriction(c, enumeration)
    const = {}
    enumeration.each do |value|
      constname = safeconstname(value)
      const[constname] ||= 0
      if (const[constname] += 1) > 1
        constname += "_#{const[constname]}"
      end
      c.def_const(constname, ndq(value))
    end
  end

  def dump_simpleclassdef(qname, type_or_element)
    base = basetype_class(type_or_element.simplecontent.base)
    c = ClassDef.new(create_class_name(qname), '::String')
    c.comment = "#{qname}\n  contains #{base}"
    init_lines = []
    unless type_or_element.attributes.empty?
      define_attribute(c, type_or_element.attributes)
      init_lines << "@__xmlattr = {}"
    end
    c.def_method('initialize', '*arg') do
      "super\n" + init_lines.join("\n")
    end
    c.dump
  end

  def dump_complextypedef(qname, type, qualified = false)
    case type.compoundtype
    when :TYPE_STRUCT, :TYPE_EMPTY
      dump_classdef(qname, type, qualified)
    when :TYPE_ARRAY
      dump_arraydef(qname, type)
    when :TYPE_SIMPLE
      dump_simpleclassdef(qname, type)
    when :TYPE_MAP
      # mapped as a general Hash
      nil
    else
      raise RuntimeError.new(
        "unknown kind of complexContent: #{type.compoundtype}")
    end
  end

  def dump_classdef(qname, typedef, qualified = false)
    if @faulttypes and @faulttypes.index(qname)
      c = ClassDef.new(create_class_name(qname), '::StandardError')
    else
      c = ClassDef.new(create_class_name(qname))
    end
    c.comment = "#{qname}"
    c.def_classvar('schema_type', ndq(qname.name))
    c.def_classvar('schema_ns', ndq(qname.namespace))
    c.def_classvar('schema_qualified', dq('true')) if qualified
    schema_element, init_lines, init_params =
      parse_elements(c, typedef.elements, qname.namespace)
    if typedef.choice?
      schema_element.unshift(:choice)
    end
    unless typedef.attributes.empty?
      define_attribute(c, typedef.attributes)
      init_lines << "@__xmlattr = {}"
    end
    c.def_classvar('schema_element',
      dump_schema_element_definition(schema_element, 2)
    )
    c.def_method('initialize', *init_params) do
      init_lines.join("\n")
    end
    c.dump
  end

  def dump_schema_element_definition(definition, indent = 0)
    return '[]' if definition.empty?
    if definition[0] == :choice
      definition.shift
      "[ :choice,\n" + ' ' * indent +
        dump_schema_element(definition, indent) + "\n]"
    elsif definition[0].is_a?(::Array)
      "[\n" + ' ' * indent +
        dump_schema_element(definition, indent) + "\n]"
    else
      varname, name, type = definition
      '[' +
        (
          if name
            varname.dump + ', [' + ndq(type) + ', ' + dqname(name) + ']'
          else
            varname.dump + ', ' + ndq(type)
          end
        ) +
      ']'
    end
  end

  def dump_schema_element(schema_element, indent = 0)
    delimiter = ",\n" + " " * indent
    schema_element.collect { |definition|
      dump_schema_element_definition(definition, indent + 2)
    }.join(delimiter)
  end

  def parse_elements(c, elements, base_namespace)
    schema_element = []
    init_lines = []
    init_params = []
    any = false
    elements.each do |element|
      case element
      when XMLSchema::Any
        # only 1 <any/> is allowed for now.
        raise RuntimeError.new("duplicated 'any'") if any
        any = true
        attrname = '__xmlele_any'
        c.def_attr(attrname, false, attrname)
        c.def_method('set_any', 'elements') do
          '@__xmlele_any = elements'
        end
        init_lines << "@__xmlele_any = nil"
        varname = 'any' # not used
        eleqname = XSD::AnyTypeName
        type = nil
        schema_element << [varname, eleqname, type]
      when XMLSchema::Element
        if element.type == XSD::AnyTypeName
          type = nil
        elsif klass = element_basetype(element)
          type = klass.name
        elsif element.type
          type = create_class_name(element.type)
        elsif element.ref
          type = create_class_name(element.ref)
        else
          type = nil      # means anyType.
          # do we define a class for local complexType from it's name?
          #   type = create_class_name(element.name)
          # <element>
          #   <complexType>
          #     <seq...>
          #   </complexType>
          # </element>
        end
        name = name_element(element).name
        #attrname = safemethodname?(name) ? name : safemethodname(name)
        attrname = safemethodname(name)
        varname = safevarname(name)
        c.def_attr(attrname, true, varname)
        init_lines << "@#{varname} = #{varname}"
        if element.map_as_array?
          init_params << "#{varname} = []"
          if type
            type << '[]'
          else
            type = '[]'
          end
        else
          init_params << "#{varname} = nil"
        end
        # nil means @@schema_ns + varname
        eleqname = element.name || element.ref.name
        if eleqname && varname == name && eleqname.namespace == base_namespace
          eleqname = nil
        end
        schema_element << [varname, eleqname, type]
      when WSDL::XMLSchema::Sequence
        child_schema_element, child_init_lines, child_init_params =
          parse_elements(c, element.elements, base_namespace)
        schema_element << child_schema_element
        init_lines.concat(child_init_lines)
        init_params.concat(child_init_params)
      when WSDL::XMLSchema::Choice
        child_schema_element, child_init_lines, child_init_params =
          parse_elements(c, element.elements, base_namespace)
        child_schema_element.unshift(:choice)
        schema_element << child_schema_element
        init_lines.concat(child_init_lines)
        init_params.concat(child_init_params)
      else
        raise RuntimeError.new("unknown type: #{element}")
      end
    end
    [schema_element, init_lines, init_params]
  end

  def element_basetype(ele)
    if klass = basetype_class(ele.type)
      klass
    elsif ele.local_simpletype
      basetype_class(ele.local_simpletype.base)
    else
      nil
    end
  end

  def attribute_basetype(attr)
    if klass = basetype_class(attr.type)
      klass
    elsif attr.local_simpletype
      basetype_class(attr.local_simpletype.base)
    else
      nil
    end
  end

  def basetype_class(type)
    return nil if type.nil?
    if simpletype = @simpletypes[type]
      basetype_mapped_class(simpletype.base)
    else
      basetype_mapped_class(type)
    end
  end

  def define_attribute(c, attributes)
    schema_attribute = []
    attributes.each do |attribute|
      name = name_attribute(attribute)
      if klass = attribute_basetype(attribute)
        type = klass.name
      else
        type = nil
      end
      methodname = safemethodname('xmlattr_' + name.name)
      c.def_method(methodname) do <<-__EOD__
          (@__xmlattr ||= {})[#{dqname(name)}]
        __EOD__
      end
      c.def_method(methodname + '=', 'value') do <<-__EOD__
          (@__xmlattr ||= {})[#{dqname(name)}] = value
        __EOD__
      end
      schema_attribute << [name, type]
    end
    c.def_classvar('schema_attribute',
      "{\n  " +
        schema_attribute.collect { |name, type|
          dqname(name) + ' => ' + ndq(type)
        }.join(",\n  ") +
      "\n}"
    )
  end

  def name_element(element)
    return element.name if element.name 
    return element.ref if element.ref
    raise RuntimeError.new("cannot define name of #{element}")
  end

  def name_attribute(attribute)
    return attribute.name if attribute.name 
    return attribute.ref if attribute.ref
    raise RuntimeError.new("cannot define name of #{attribute}")
  end

  DEFAULT_ITEM_NAME = XSD::QName.new(nil, 'item')

  def dump_arraydef(qname, complextype)
    c = ClassDef.new(create_class_name(qname), '::Array')
    c.comment = "#{qname}"
    child_type = complextype.child_type
    c.def_classvar('schema_type', ndq(child_type.name))
    c.def_classvar('schema_ns', ndq(child_type.namespace))
    child_element = complextype.find_aryelement
    schema_element = []
    if child_type == XSD::AnyTypeName
      type = nil
    elsif child_element and (klass = element_basetype(child_element))
      type = klass.name
    elsif child_type
      type = create_class_name(child_type)
    else
      type = nil
    end
    if child_element
      if child_element.map_as_array?
        type << '[]' if type
      end
      child_element_name = child_element.name
    else
      child_element_name = DEFAULT_ITEM_NAME
    end
    schema_element << [child_element_name.name, child_element_name, type]
    c.def_classvar('schema_element',
      dump_schema_element_definition(schema_element, 2)
    )
    c.dump
  end
end


end
end
