require 'where_to/version'
require 'where_to/locator'
require 'where_to/location'
require 'where_to/configuration'

module WhereTo
  class << self
    attr_accessor :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.reset
    @configuration = Configuration.new
  end

  def self.configure
    yield configuration
  end

end 
