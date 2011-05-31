# encoding: utf-8
require 'date'
require 'abstract_unit'
require 'inflector_test_cases'

class StringInflectionsTest < Test::Unit::TestCase
  include InflectorTestCases

  def test_pluralize
    SingularToPlural.each do |singular, plural|
      assert_equal(plural, singular.pluralize)
    end

    assert_equal("plurals", "plurals".pluralize)
  end

  def test_singularize
    SingularToPlural.each do |singular, plural|
      assert_equal(singular, plural.singularize)
    end
  end

  def test_titleize
    MixtureToTitleCase.each do |before, titleized|
      assert_equal(titleized, before.titleize)
    end
  end

  def test_camelize
    CamelToUnderscore.each do |camel, underscore|
      assert_equal(camel, underscore.camelize)
    end
  end

  def test_camelize_lower
    assert_equal('capital', 'Capital'.camelize(:lower))
  end

  def test_underscore
    CamelToUnderscore.each do |camel, underscore|
      assert_equal(underscore, camel.underscore)
    end

    assert_equal "html_tidy", "HTMLTidy".underscore
    assert_equal "html_tidy_generator", "HTMLTidyGenerator".underscore
  end

  def test_underscore_to_lower_camel
    UnderscoreToLowerCamel.each do |underscored, lower_camel|
      assert_equal(lower_camel, underscored.camelize(:lower))
    end
  end

  def test_demodulize
    assert_equal "Account", "MyApplication::Billing::Account".demodulize
  end

  def test_foreign_key
    ClassNameToForeignKeyWithUnderscore.each do |klass, foreign_key|
      assert_equal(foreign_key, klass.foreign_key)
    end

    ClassNameToForeignKeyWithoutUnderscore.each do |klass, foreign_key|
      assert_equal(foreign_key, klass.foreign_key(false))
    end
  end

  def test_tableize
    ClassNameToTableName.each do |class_name, table_name|
      assert_equal(table_name, class_name.tableize)
    end
  end

  def test_classify
    ClassNameToTableName.each do |class_name, table_name|
      assert_equal(class_name, table_name.classify)
    end
  end

  def test_string_parameterized_normal
    StringToParameterized.each do |normal, slugged|
      assert_equal(normal.parameterize, slugged)
    end
  end

  def test_string_parameterized_no_separator
    StringToParameterizeWithNoSeparator.each do |normal, slugged|
      assert_equal(normal.parameterize(''), slugged)
    end
  end

  def test_string_parameterized_underscore
    StringToParameterizeWithUnderscore.each do |normal, slugged|
      assert_equal(normal.parameterize('_'), slugged)
    end
  end

  def test_humanize
    UnderscoreToHuman.each do |underscore, human|
      assert_equal(human, underscore.humanize)
    end
  end

  def test_ord
    assert_equal 97, 'a'.ord
    assert_equal 97, 'abc'.ord
  end

  def test_string_to_time
    assert_equal Time.utc(2005, 2, 27, 23, 50), "2005-02-27 23:50".to_time
    assert_equal Time.local(2005, 2, 27, 23, 50), "2005-02-27 23:50".to_time(:local)
    assert_equal DateTime.civil(2039, 2, 27, 23, 50), "2039-02-27 23:50".to_time
    assert_equal Time.local_time(2039, 2, 27, 23, 50), "2039-02-27 23:50".to_time(:local)
  end
  
  def test_string_to_datetime
    assert_equal DateTime.civil(2039, 2, 27, 23, 50), "2039-02-27 23:50".to_datetime
    assert_equal 0, "2039-02-27 23:50".to_datetime.offset # use UTC offset
    assert_equal ::Date::ITALY, "2039-02-27 23:50".to_datetime.start # use Ruby's default start value
  end
  
  def test_string_to_date
    assert_equal Date.new(2005, 2, 27), "2005-02-27".to_date
  end

  def test_access
    s = "hello"
    assert_equal "h", s.at(0)

    assert_equal "llo", s.from(2)
    assert_equal "hel", s.to(2)

    assert_equal "h", s.first
    assert_equal "he", s.first(2)
    assert_equal "", s.first(0)

    assert_equal "o", s.last
    assert_equal "llo", s.last(3)
    assert_equal "hello", s.last(10)
    assert_equal "", s.last(0)

    assert_equal 'x', 'x'.first
    assert_equal 'x', 'x'.first(4)

    assert_equal 'x', 'x'.last
    assert_equal 'x', 'x'.last(4)
  end

  def test_access_returns_a_real_string
    hash = {}
    hash["h"] = true
    hash["hello123".at(0)] = true
    assert_equal %w(h), hash.keys

    hash = {}
    hash["llo"] = true
    hash["hello".from(2)] = true
    assert_equal %w(llo), hash.keys

    hash = {}
    hash["hel"] = true
    hash["hello".to(2)] = true
    assert_equal %w(hel), hash.keys

    hash = {}
    hash["hello"] = true
    hash["123hello".last(5)] = true
    assert_equal %w(hello), hash.keys

    hash = {}
    hash["hello"] = true
    hash["hello123".first(5)] = true
    assert_equal %w(hello), hash.keys
  end

  def test_starts_ends_with_alias
    s = "hello"
    assert s.starts_with?('h')
    assert s.starts_with?('hel')
    assert !s.starts_with?(:hel)
    assert !s.starts_with?('el')

    assert s.start_with?('h')
    assert s.start_with?('hel')
    assert !s.start_with?('el')

    assert s.ends_with?('o')
    assert s.ends_with?('lo')
    assert !s.ends_with?(:lo)
    assert !s.ends_with?('el')

    assert s.end_with?('o')
    assert s.end_with?('lo')
    assert !s.end_with?('el')
  end

  def test_string_squish
    original = %{ A string with tabs(\t\t), newlines(\n\n), and
                  many spaces(  ). }

    expected = "A string with tabs( ), newlines( ), and many spaces( )."

    # Make sure squish returns what we expect:
    assert_equal original.squish,  expected
    # But doesn't modify the original string:
    assert_not_equal original, expected

    # Make sure squish! returns what we expect:
    assert_equal original.squish!, expected
    # And changes the original string:
    assert_equal original, expected
  end

  if RUBY_VERSION < '1.9'
    def test_each_char_with_utf8_string_when_kcode_is_utf8
      with_kcode('UTF8') do
        '€2.99'.each_char do |char|
          assert_not_equal 1, char.length
          break
        end
      end
    end
  end
end

class StringBehaviourTest < Test::Unit::TestCase
  def test_acts_like_string
    assert 'Bambi'.acts_like_string?
  end
end

class CoreExtStringMultibyteTest < ActiveSupport::TestCase
  UNICODE_STRING = 'こにちわ'
  ASCII_STRING = 'ohayo'
  BYTE_STRING = "\270\236\010\210\245"

  def test_core_ext_adds_mb_chars
    assert UNICODE_STRING.respond_to?(:mb_chars)
  end

  def test_string_should_recognize_utf8_strings
    assert UNICODE_STRING.is_utf8?
    assert ASCII_STRING.is_utf8?
    assert !BYTE_STRING.is_utf8?
  end

  if RUBY_VERSION < '1.8.7'
    def test_core_ext_adds_chars
      assert UNICODE_STRING.respond_to?(:chars)
    end

    def test_chars_warns_about_deprecation
      assert_deprecated("String#chars") do
        ''.chars
      end
    end
  end

  if RUBY_VERSION < '1.9'
    def test_mb_chars_returns_self_when_kcode_not_set
      with_kcode('none') do
        assert UNICODE_STRING.mb_chars.kind_of?(String)
      end
    end

    def test_mb_chars_returns_an_instance_of_the_chars_proxy_when_kcode_utf8
      with_kcode('UTF8') do
        assert UNICODE_STRING.mb_chars.kind_of?(ActiveSupport::Multibyte.proxy_class)
      end
    end
  end

  if RUBY_VERSION >= '1.9'
    def test_mb_chars_returns_string
      assert UNICODE_STRING.mb_chars.kind_of?(String)
    end
  end
end

class StringBytesizeTest < Test::Unit::TestCase
  def test_bytesize
    assert_respond_to 'foo', :bytesize
    assert_equal 3, 'foo'.bytesize
  end
end

class OutputSafetyTest < ActiveSupport::TestCase
  def setup
    @string = "hello"
  end

  test "A string is unsafe by default" do
    assert !@string.html_safe?
  end

  test "Marking a string html_safe! doesn't work unless rails_xss is installed" do
    assert_raise(NoMethodError) { @string.html_safe! }
  end

  test "A string can be marked safe" do
    string = @string.html_safe
    assert string.html_safe?
  end

  test "Marking a string safe returns the string" do
    assert_equal @string, @string.html_safe
  end

  test "A fixnum is safe by default" do
    assert 5.html_safe?
  end

  test "An object is unsafe by default" do
    assert !Object.new.html_safe?
  end

  test "Adding a safe string to another safe string returns a safe string" do
    @other_string = "other".html_safe
    string = @string.html_safe
    @combination = @other_string + string

    assert_equal "otherhello", @combination
    assert @combination.html_safe?
  end

  test "Adding an unsafe string to a safe string doesn't escape it without rails_xss but returns a safe string" do
    @other_string = "other".html_safe
    @combination = @other_string + "<foo>"
    @other_combination = @string + "<foo>"

    assert_equal "other<foo>", @combination
    assert_equal "hello<foo>", @other_combination

    assert @combination.html_safe?
    assert !@other_combination.html_safe?
  end

  test "Concatting safe onto unsafe yields unsafe" do
    @other_string = "other"
    string = @string.html_safe

    @other_string.concat(string)
    assert !@other_string.html_safe?
  end

  test "Concatting unsafe onto safe yields safe by not escaped without rails_xss" do
    @other_string = "other".html_safe
    string = @other_string.concat("<foo>")
    assert_equal "other<foo>", string
    assert string.html_safe?
  end

  test "Concatting safe onto safe yields safe" do
    @other_string = "other".html_safe
    string = @string.html_safe

    @other_string.concat(string)
    assert @other_string.html_safe?
  end

  test "Concatting safe onto unsafe with << yields unsafe" do
    @other_string = "other"
    string = @string.html_safe

    @other_string << string
    assert !@other_string.html_safe?
  end

  test "Concatting unsafe onto safe with << yields safe but not escaped without rails_xss" do
    @other_string = "other".html_safe
    string = @other_string << "<foo>"
    assert_equal "other<foo>", string
    assert string.html_safe?
  end

  test "Concatting safe onto safe with << yields safe" do
    @other_string = "other".html_safe
    @string.html_safe

    @other_string << @string
    assert @other_string.html_safe?
  end

  test "Concatting a fixnum to safe always yields safe" do
    string = @string.html_safe
    string = string.concat(13)
    assert_equal "hello".concat(13), string
    assert string.html_safe?
  end

  test 'emits normal string yaml' do
    assert_equal 'foo'.to_yaml, 'foo'.html_safe.to_yaml(:foo => 1)
  end

  test 'yaml output using +' do
    assert_equal "--- foobar\n", ('foo' + 'bar').to_yaml
  end

  test 'yaml output using <<' do
    assert_equal "--- foobar\n", ('foo' << 'bar').to_yaml
  end
end
