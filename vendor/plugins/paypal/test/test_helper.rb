$:.unshift(File.dirname(__FILE__) + '/../lib')

require 'rubygems'
require 'test/unit'
require 'active_support/binding_of_caller'
require 'active_support/breakpoint'
require "#{File.dirname(__FILE__)}/../init"

#config = YAML::load(IO.read(File.dirname(__FILE__) + '/database.yml'))
#ActiveRecord::Base.establish_connection(config[ENV['DB'] || 'sqlite'])
