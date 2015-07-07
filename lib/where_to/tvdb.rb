require 'tvdb_party'

module WhereTo
  class TVDB 
    attr_accessor :series_title, :episode_number, :season, :episode_title, :season_airdate, :series_id
    attr_reader :api_key

    def initialize(params = {})
      load_values_from params
      @api_key = WhereTo.configuration.tvdb_api_key
      @db = TvdbParty::Search.new api_key
    end

    # Probably split into lookup_season, lookup_episode (which lazy instantiate)
    # and lookup_season!, lookup_episode! (which force db hit):w
    def lookup!
      validate!
      results = @db.search(series_title).first unless series_id
      series  = @db.get_series_by_id (series_id || results['seriesid'])
      episode = series.get_episode season, episode_number
      raise "It doesn't look like the series #{series.name} has an episode #{episode_number} for season #{season}" unless episode
      @episode_title  = episode.name
      @season_airdate = episode.air_date.year 

      updated = {}
      updated[:episode_title]  = episode_title
      updated[:season_airdate] = season_airdate
      updated
    rescue URI::InvalidURIError
      raise 'You need to configure your TVDB API key before looking up episode information'
    end

    def lookup_series(series_id)
      @db.get_series_by_id series_id 
    end

    def validate!
      raise 'A series title is required to lookup episode information' if series_title.nil? && series_id.nil?
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
      set_unless_nil :season,         hash[:season_number]
      set_unless_nil :season,         hash[:season]
      set_unless_nil :season_airdate, hash[:season_airdate]
      set_unless_nil :episode_title,  hash[:episode_title]
      set_unless_nil :episode_number, hash[:episode_number]
      set_unless_nil :episode_quality, hash[:episode_quality]
      set_unless_nil :episode_extension, hash[:episode_extension]
      set_unless_nil :series_id,         hash[:series_id]
    end
  end
end
