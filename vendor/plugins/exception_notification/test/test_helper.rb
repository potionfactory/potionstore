require 'test/unit'
require 'rubygems'
require 'active_support'

$:.unshift File.join(File.dirname(__FILE__), '../lib')

Rails.root = '.' unless defined?(Rails.root)
