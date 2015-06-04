module WhereTo
  class Configuration
    attr_accessor :folder_format

    def initialize
      @folder_format = "%series_title/Season %season_number (%season_airdate)/"
    end

    def folder_format
      @folder_format.dup
    end

  end
end