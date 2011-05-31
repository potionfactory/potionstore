# encoding: utf-8

module InflectorTestCases
  SingularToPlural = {
    "search"      => "searches",
    "switch"      => "switches",
    "fix"         => "fixes",
    "box"         => "boxes",
    "process"     => "processes",
    "address"     => "addresses",
    "case"        => "cases",
    "stack"       => "stacks",
    "wish"        => "wishes",
    "fish"        => "fish",
    "jeans"       => "jeans",
    "funky jeans" => "funky jeans",
    
    "category"    => "categories",
    "query"       => "queries",
    "ability"     => "abilities",
    "agency"      => "agencies",
    "movie"       => "movies",

    "archive"     => "archives",

    "index"       => "indices",

    "wife"        => "wives",
    "safe"        => "saves",
    "half"        => "halves",

    "move"        => "moves",

    "salesperson" => "salespeople",
    "person"      => "people",

    "spokesman"   => "spokesmen",
    "man"         => "men",
    "woman"       => "women",

    "basis"       => "bases",
    "diagnosis"   => "diagnoses",
    "diagnosis_a" => "diagnosis_as",

    "datum"       => "data",
    "medium"      => "media",
    "analysis"    => "analyses",

    "node_child"  => "node_children",
    "child"       => "children",

    "experience"  => "experiences",
    "day"         => "days",

    "comment"     => "comments",
    "foobar"      => "foobars",
    "newsletter"  => "newsletters",

    "old_news"    => "old_news",
    "news"        => "news",

    "series"      => "series",
    "species"     => "species",

    "quiz"        => "quizzes",

    "perspective" => "perspectives",

    "ox"          => "oxen",
    "photo"       => "photos",
    "buffalo"     => "buffaloes",
    "tomato"      => "tomatoes",
    "dwarf"       => "dwarves",
    "elf"         => "elves",
    "information" => "information",
    "equipment"   => "equipment",
    "bus"         => "buses",
    "status"      => "statuses",
    "status_code" => "status_codes",
    "mouse"       => "mice",

    "louse"       => "lice",
    "house"       => "houses",
    "octopus"     => "octopi",
    "virus"       => "viri",
    "alias"       => "aliases",
    "portfolio"   => "portfolios",

    "vertex"      => "vertices",
    "matrix"      => "matrices",
    "matrix_fu"   => "matrix_fus",

    "axis"        => "axes",
    "testis"      => "testes",
    "crisis"      => "crises",

    "rice"        => "rice",
    "shoe"        => "shoes",

    "horse"       => "horses",
    "prize"       => "prizes",
    "edge"        => "edges",

    "cow"         => "kine",
    "database"    => "databases"
  }

  CamelToUnderscore = {
    "Product"               => "product",
    "SpecialGuest"          => "special_guest",
    "ApplicationController" => "application_controller",
    "Area51Controller"      => "area51_controller"
  }

  UnderscoreToLowerCamel = {
    "product"                => "product",
    "special_guest"          => "specialGuest",
    "application_controller" => "applicationController",
    "area51_controller"      => "area51Controller"
  }

  CamelToUnderscoreWithoutReverse = {
    "HTMLTidy"              => "html_tidy",
    "HTMLTidyGenerator"     => "html_tidy_generator",
    "FreeBSD"               => "free_bsd",
    "HTML"                  => "html",
  }

  CamelWithModuleToUnderscoreWithSlash = {
    "Admin::Product" => "admin/product",
    "Users::Commission::Department" => "users/commission/department",
    "UsersSection::CommissionDepartment" => "users_section/commission_department",
  }

  ClassNameToForeignKeyWithUnderscore = {
    "Person" => "person_id",
    "MyApplication::Billing::Account" => "account_id"
  }

  ClassNameToForeignKeyWithoutUnderscore = {
    "Person" => "personid",
    "MyApplication::Billing::Account" => "accountid"
  }

  ClassNameToTableName = {
    "PrimarySpokesman" => "primary_spokesmen",
    "NodeChild"        => "node_children"
  }

  StringToParameterized = {
    "Donald E. Knuth"                     => "donald-e-knuth",
    "Random text with *(bad)* characters" => "random-text-with-bad-characters",
    "Allow_Under_Scores"                  => "allow_under_scores",
    "Trailing bad characters!@#"          => "trailing-bad-characters",
    "!@#Leading bad characters"           => "leading-bad-characters",
    "Squeeze   separators"                => "squeeze-separators",
    "Test with + sign"                    => "test-with-sign",
    "Test with malformed utf8 \251"       => "test-with-malformed-utf8"
  }

  StringToParameterizeWithNoSeparator = {
    "Donald E. Knuth"                     => "donaldeknuth",
    "Random text with *(bad)* characters" => "randomtextwithbadcharacters",
    "Trailing bad characters!@#"          => "trailingbadcharacters",
    "!@#Leading bad characters"           => "leadingbadcharacters",
    "Squeeze   separators"                => "squeezeseparators",
    "Test with + sign"                    => "testwithsign",
    "Test with malformed utf8 \251"       => "testwithmalformedutf8"
  }

  StringToParameterizeWithUnderscore = {
    "Donald E. Knuth"                     => "donald_e_knuth",
    "Random text with *(bad)* characters" => "random_text_with_bad_characters",
    "Trailing bad characters!@#"          => "trailing_bad_characters",
    "!@#Leading bad characters"           => "leading_bad_characters",
    "Squeeze   separators"                => "squeeze_separators",
    "Test with + sign"                    => "test_with_sign",
    "Test with malformed utf8 \251"       => "test_with_malformed_utf8"
  }

  # Ruby 1.9 doesn't do Unicode normalization yet.
  if RUBY_VERSION >= '1.9'
    StringToParameterizedAndNormalized = {
      "Malmö"                               => "malm",
      "Garçons"                             => "gar-ons",
      "Ops \251"                            => "ops"
    }
  else
    StringToParameterizedAndNormalized = {
      "Malmö"                               => "malmo",
      "Garçons"                             => "garcons",
      "Ops \251"                            => "ops"
    }
  end

  UnderscoreToHuman = {
    "employee_salary" => "Employee salary",
    "employee_id"     => "Employee",
    "underground"     => "Underground"
  }

  MixtureToTitleCase = {
    'active_record'       => 'Active Record',
    'ActiveRecord'        => 'Active Record',
    'action web service'  => 'Action Web Service',
    'Action Web Service'  => 'Action Web Service',
    'Action web service'  => 'Action Web Service',
    'actionwebservice'    => 'Actionwebservice',
    'Actionwebservice'    => 'Actionwebservice',
    "david's code"        => "David's Code",
    "David's code"        => "David's Code",
    "david's Code"        => "David's Code"
  }

  OrdinalNumbers = {
    "0" => "0th",
    "1" => "1st",
    "2" => "2nd",
    "3" => "3rd",
    "4" => "4th",
    "5" => "5th",
    "6" => "6th",
    "7" => "7th",
    "8" => "8th",
    "9" => "9th",
    "10" => "10th",
    "11" => "11th",
    "12" => "12th",
    "13" => "13th",
    "14" => "14th",
    "20" => "20th",
    "21" => "21st",
    "22" => "22nd",
    "23" => "23rd",
    "24" => "24th",
    "100" => "100th",
    "101" => "101st",
    "102" => "102nd",
    "103" => "103rd",
    "104" => "104th",
    "110" => "110th",
    "111" => "111th",
    "112" => "112th",
    "113" => "113th",
    "1000" => "1000th",
    "1001" => "1001st"
  }

  UnderscoresToDashes = {
    "street"                => "street",
    "street_address"        => "street-address",
    "person_street_address" => "person-street-address"
  }

  Irregularities = {
    'person' => 'people',
    'man'    => 'men',
    'child'  => 'children',
    'sex'    => 'sexes',
    'move'   => 'moves',
  }
end
