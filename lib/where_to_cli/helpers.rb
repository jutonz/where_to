module WhereToCLI
  module Helpers
    def self.check_location!(location)
      return '.' if location.nil?
      raise "The location '#{location}' does not exist" unless File.exist? location
      location
    end
  end
end
