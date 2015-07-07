require 'date'

# Require all the libraries!
Dir[File.dirname(__FILE__) + "/where_to/**/*.rb"].each { |f| require_relative f }

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
