require 'where_to/location'
require 'yaml'

module WhereTo
  class Locator
    attr_accessor :title, :airdate, :season, :season_airdate

    def initialize(hash = {})
      load_values_from hash
    end
  
    def locate(hash = {})
      load_values_from hash
      validate!
    end

    def validate!
      raise 'A season airdate is required to locate an episode' if season_airdate == nil
      raise 'A season number is required to locate an episode' if season.nil? 
    end

    private

    def set_unless_nil(key, value)
      send("#{key}=".to_sym, value) unless value.nil?
    end

    def load_values_from(hash = {})
      set_unless_nil :title,          hash[:title]
      set_unless_nil :airdate,        hash[:airdate]
      set_unless_nil :season,         hash[:season]
      set_unless_nil :season_airdate, hash[:season_airdate]
    end
  end
end