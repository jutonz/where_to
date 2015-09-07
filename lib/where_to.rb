require 'date'

# Require all the libraries!
require_files = %w(
  configuration
  episode_formatter
  location
  locator
  tvdb
  version
  error/no_files_error
).each do |require_file|
  require_relative "where_to/#{require_file}"
end

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
