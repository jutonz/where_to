require 'tvdb_party'

module WhereTo
  class TVDB 
    attr_accessor :series_title, :episode_number, :season, :episode_title

    def initialize(params = {})
      load_values_from params
      @db = TvdbParty::Search.new WhereTo.configuration.tvdb_api_key
    end

    def lookup!
      validate!
      results = @db.search(series_title).first
      series  = @db.get_series_by_id results['seriesid']
      episode = series.get_episode season, episode_number
      @episode_title = episode.name
    rescue URI::InvalidURIError
      raise 'You need to configure your TVDB API key before looking up episode information'
    end

    def validate!
      raise 'A series title is required to lookup episode information' if series_title.nil?
      raise 'An episode number is required to lookup episode information' if episode_number.nil?
      raise 'A season number is required to lookup episode information' if season.nil?
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
      set_unless_nil :episode_title,  hash[:episode_title]
      set_unless_nil :episode_number, hash[:episode_number]
      set_unless_nil :episode_quality, hash[:episode_quality]
      set_unless_nil :episode_extension, hash[:episode_extension]
    end
  end
end