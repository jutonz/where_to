module WhereTo
  class EpisodeFormatter
    attr_accessor :series_title, :season_number, :episode_title, :episode_number
    attr_accessor :quality, :extension, :group
    DEFAULT_EXTENSION = '.mkv'

    def initialize(hash = {}, series_title: hash[:series_title], season_number: hash[:season_number], episode_title: hash[:episode_title], episode_number: hash[:episode_number], extension: hash[:extension], quality: hash[:quality], group: hash[:group], series_id: hash[:series_id])
      set_unless_nil :series_title,   series_title
      set_unless_nil :season_number,  season_number
      set_unless_nil :episode_title,  episode_title
      set_unless_nil :episode_number, episode_number
      set_unless_nil :quality,        quality
      set_unless_nil :extension,      extension,      default: DEFAULT_EXTENSION
      set_unless_nil :group,          group
    end

    def format!
      validate!
      formatted = []
      formatted << series_title.downcase.gsub(' ', '.')
      formatted << "SxxEyy".gsub('xx', season_number.to_s.rjust(2, '0')).gsub('yy', episode_number.to_s.rjust(2, '0'))
      formatted << episode_title.downcase.gsub(' ', '.')
      formatted << quality.downcase if quality
      formatted = formatted.join('.')

      formatted << "-#{group}" if group
      formatted << extension

      formatted
    end

    def validate!
      raise 'A series title is required to format an episode title.' unless series_title
      raise 'A season number is required to format an episode title.' unless season_number
      raise 'An episode title is required to format an episode title.' unless episode_title
      raise 'An episode number is required to format an episode title.' unless episode_number
      true
    end

    private

    def set_unless_nil(key, value, default: nil)
      if value
        send("#{key}=".to_sym, value)
      elsif default
        send("#{key}=".to_sym, default)
      end
    end

  end
end
