# WSDL4R - XMLSchema complexContent definition for WSDL.
# Copyright (C) 2002, 2003  NAKAMURA, Hiroshi <nahi@ruby-lang.org>.

# This program is copyrighted free software by NAKAMURA, Hiroshi.  You can
# redistribute it and/or modify it under the same terms of Ruby's license;
# either the dual license version in 2003, or any later version.


require 'wsdl/info'
require 'xsd/namedelements'


module WSDL
module XMLSchema


class ComplexContent < Info
  attr_accessor :restriction
  attr_accessor :extension

  def initialize
    super
    @restriction = nil
    @extension = nil
  end

  def targetnamespace
    parent.targetnamespace
  end

  def elementformdefault
    parent.elementformdefault
  end

  def content
    @extension || @restriction
  end

  def have_any?
    content ? content.have_any? : nil
  end

  def choice?
    content ? content.choice? : nil
  end

  def elements
    content ? content.elements : XSD::NamedElements::Empty
  end

  def attributes
    content.attributes
  end

  def check_type
    if content
      content.check_type
    else
      raise ArgumentError.new("incomplete complexContent")
    end
  end

  def parse_element(element)
    case element
    when RestrictionName
      raise ArgumentError.new("incomplete complexContent") if content
      @restriction = ComplexRestriction.new
    when ExtensionName
      raise ArgumentError.new("incomplete complexContent") if content
      @extension = ComplexExtension.new
    end
  end

  def parse_attr(attr, value)
    nil
  end
end


end
end
