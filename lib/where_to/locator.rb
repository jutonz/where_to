require 'where_to/location'
require 'where_to/configuration'
require 'yaml'

module WhereTo
  class Locator
    attr_accessor :series_title, :airdate, :season, :season_airdate
    attr_accessor :episode_title, :episode_number, :episode_quality, :episode_extension

    def initialize(hash = {})
      load_values_from hash
    end
  
    def locate(hash = {})
      load_values_from hash
      validate!

      output = WhereTo.configuration.folder_format
      output.gsub! '%series_title',   series_title
      output.gsub! '%season_number',  season.to_s
      output.gsub! '%season_airdate', season_airdate.to_s

      if episode_title and episode_number
        formatter = WhereTo::EpisodeFormatter.new params
        output << formatter.format!
      end

      WhereTo::Location.new output
    end

    def validate!
      raise 'A season airdate is required to locate an episode' if season_airdate == nil
      raise 'A season number is required to locate an episode' if season.nil?
      true
    end

    def params
      _params = {}
      _params[:series_title]   = series_title
      _params[:season_number]  = season
      _params[:episode_title]  = episode_title
      _params[:episode_number] = episode_number
      _params[:quality]        = episode_quality
      _params[:extension]      = episode_extension
      _params
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
      set_unless_nil :episode_title,  hash[:episode_title]
      set_unless_nil :episode_number, hash[:episode_number]
      set_unless_nil :episode_quality, hash[:episode_quality]
      set_unless_nil :episode_extension, hash[:episode_extension]
    end
  end
end