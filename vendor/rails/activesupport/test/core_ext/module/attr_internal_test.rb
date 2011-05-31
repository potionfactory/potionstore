require 'abstract_unit'

class AttrInternalTest < Test::Unit::TestCase
  def setup
    @target = Class.new
    @instance = @target.new
  end

  def test_reader
    assert_nothing_raised { @target.attr_internal_reader :foo }

    assert !@instance.instance_variable_defined?('@_foo')
    assert_raise(NoMethodError) { @instance.foo = 1 }

    @instance.instance_variable_set('@_foo', 1)
    assert_nothing_raised { assert_equal 1, @instance.foo }
  end

  def test_writer
    assert_nothing_raised { @target.attr_internal_writer :foo }

    assert !@instance.instance_variable_defined?('@_foo')
    assert_nothing_raised { assert_equal 1, @instance.foo = 1 }

    assert_equal 1, @instance.instance_variable_get('@_foo')
    assert_raise(NoMethodError) { @instance.foo }
  end

  def test_accessor
    assert_nothing_raised { @target.attr_internal :foo }

    assert !@instance.instance_variable_defined?('@_foo')
    assert_nothing_raised { assert_equal 1, @instance.foo = 1 }

    assert_equal 1, @instance.instance_variable_get('@_foo')
    assert_nothing_raised { assert_equal 1, @instance.foo }
  end

  def test_naming_format
    assert_equal '@_%s', @target.attr_internal_naming_format
    assert_nothing_raised { @target.attr_internal_naming_format = '@abc%sdef' }
    @target.attr_internal :foo

    assert !@instance.instance_variable_defined?('@_foo')
    assert !@instance.instance_variable_defined?('@abcfoodef')
    assert_nothing_raised { @instance.foo = 1 }
    assert !@instance.instance_variable_defined?('@_foo')
    assert @instance.instance_variable_defined?('@abcfoodef')
  ensure
    @target.attr_internal_naming_format = '@_%s'
  end
end
