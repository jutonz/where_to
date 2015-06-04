$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'simplecov'
require 'simplecov-shield'
SimpleCov.start
SimpleCov.formatter = SimpleCov::Formatter::ShieldFormatter

require 'where_to'
require 'where_to/location'
require 'where_to/locator'