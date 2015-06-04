require 'where_to/location'
require 'yaml'

module WhereTo
  class Locator
    attr_accessor :series_title, :airdate, :season, :season_airdate
    FORMAT_FILE = 'lib/where_to/format.yml'

    def initialize(hash = {})
      load_values_from hash
      @format_file = YAML.load_file FORMAT_FILE
    end
  
    def locate(hash = {})
      load_values_from hash
      validate!

      output = @format_file['format']
      output.gsub! '%series_title',   series_title
      output.gsub! '%season_number',  season.to_s
      output.gsub! '%season_airdate', season_airdate.to_s
      WhereTo::Location.new output
    end

    def validate!
      raise 'A season airdate is required to locate an episode' if season_airdate == nil
      raise 'A season number is required to locate an episode' if season.nil?
      true
    end

    private

    def set_unless_nil(key, value)
      send("#{key}=".to_sym, value) unless value.nil?
    end

    def load_values_from(hash = {})
      set_unless_nil :series_title,   hash[:series_title]
      set_unless_nil :airdate,        hash[:airdate]
      set_unless_nil :season,         hash[:season]
      set_unless_nil :season_airdate, hash[:season_airdate]
    end
  end
end