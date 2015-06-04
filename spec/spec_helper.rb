$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
# require 'simplecov'
# SimpleCov.start

require 'coveralls'
Coveralls.wear!

require 'where_to'
require 'where_to/location'
require 'where_to/locator'
require 'where_to/episode_formatter'