module WhereTo
  class Configuration
    attr_accessor :folder_format, :tvdb_api_key

    def initialize
      @folder_format = "%series_title/Season %season_number (%season_airdate)/"
      @tvdb_api_key  = "You need to get one before you can lookup episode information automatically"
    end

    def folder_format
      @folder_format.dup
    end

  end
end