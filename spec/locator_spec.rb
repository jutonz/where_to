require 'spec_helper'

describe WhereTo::Locator do

  describe 'validation' do
    before do
      @options = {}
      @options[:series_title]   = 'Show title'
      @options[:season]         = 2
      @options[:airdate]        = Date.today
      @options[:season_airdate] = 2015
    end

    it 'requires a season number' do
      @options[:season] = nil
      locator = WhereTo::Locator.new @options
      expect{ locator.validate! }.to raise_error(RuntimeError, 'A season number is required to locate an episode')
    end

    it 'requires a season airdate' do
      @options[:season_airdate] = nil
      locator = WhereTo::Locator.new @options
      expect { locator.validate! }.to raise_error(RuntimeError, 'A season airdate is required to locate an episode')
    end

  end

  describe 'data storage' do

    before do
      @locator = WhereTo::Locator.new
    end

    it 'remembers a series title' do
      series_title = 'amazing title'
      @locator.series_title = series_title
      expect(@locator.series_title).to be series_title
    end

    it 'remembers a season number' do
      season_number = 2
      @locator.season = season_number
      expect(@locator.season).to be season_number
    end

    it 'remembers an episode number' do
      episode_number = 2
      @locator.episode_number = episode_number
      expect(@locator.episode_number).to be episode_number
    end

    it 'lets me increment an episode number' do
      episode_number = 2
      @locator.episode_number = episode_number
      expect(@locator.episode_number).to be episode_number

      3.times do |n|
        @locator.episode_number += 1
        expect(@locator.episode_number).to be episode_number + n + 1
      end
    end

    it 'remembers an airdate' do
      date = Date.today
      @locator.season_airdate = date
      expect(@locator.season_airdate).to be date
    end

    it 'remembers when the season aired' do
      airdate = 2015
      @locator.season_airdate = airdate
      expect(@locator.season_airdate).to be airdate
    end

    it 'can load data from a hash' do
      @options = {}
      @options[:series_title]   = 'Show title'
      @options[:season]         = 2
      @options[:airdate]        = Date.today
      @options[:season_airdate] = 2015

      locator = WhereTo::Locator.new @options

      expect(locator.series_title).to eq 'Show title'
      expect(locator.season).to eq 2
      expect(locator.airdate).to eq Date.today
      expect(locator.season_airdate).to eq 2015
    end

  end

  describe 'locating series' do
    before do 
      @options = {}
      @options[:series_title]   = 'Game of Thrones'
      @options[:season]         = 5
      @options[:season_airdate] = 2015
    end

    it 'can locate shows with a series title, season, and season airdate' do
      locator = WhereTo::Locator.new @options
      expect(locator.locate).to eq 'Game of Thrones/Season 5 (2015)/'
    end

    it 'returns a location object' do
      locator = WhereTo::Locator.new @options
      expect(locator.locate.class).to eq WhereTo::Location
    end

  end

  describe 'locating episodes' do
    before :all do 
      WhereTo.configure do |config|
        config.tvdb_api_key = ENV['TVDB_API_KEY']
      end
    end
    
    before :each do 
      @options = {}
      @options[:series_title]   = 'Game of Thrones'
      @options[:season]         = 5
      @options[:season_airdate] = 2015
      @options[:episode_title] = 'Something amazing'
      @options[:episode_number] = 3
    end

    it 'will specify a filename if an episode title and number are included' do 
      locator = WhereTo::Locator.new @options

      location = locator.locate
      expect(location.folder).to eq 'Game of Thrones/Season 5 (2015)/'
      expect(location.filename).to eq 'game.of.thrones.S05E03.something.amazing.mkv'
    end

    it 'honors custom file extensions' do
      @options[:episode_title] = 'custom file container'
      @options[:episode_extension] = '.avi' #yuck
      locator = WhereTo::Locator.new @options

      location = locator.locate
      expect(location.folder).to eq 'Game of Thrones/Season 5 (2015)/'
      expect(location.filename).to eq 'game.of.thrones.S05E03.custom.file.container.avi'
    end

    it 'will append a quality if one was specified' do
      @options[:episode_title] = 'super good quality'
      @options[:episode_quality] = '9001p'
      locator = WhereTo::Locator.new @options

      location = locator.locate
      expect(location.folder).to eq 'Game of Thrones/Season 5 (2015)/'
      expect(location.filename).to eq 'game.of.thrones.S05E03.super.good.quality.9001p.mkv'
    end

    it 'will append a group if one was specified' do
      @options[:group] = 'hellow'
      locator = WhereTo::Locator.new @options
      expect(locator.group).to eq 'hellow'

      location = locator.locate
      expect(location.folder).  to eq 'Game of Thrones/Season 5 (2015)/'
      expect(location.filename).to eq 'game.of.thrones.S05E03.something.amazing-hellow.mkv'
    end

    it 'can lookup episode information from a database' do
      locator = WhereTo::Locator.new @options
      expect(locator.season).to be 5
      locator.lookup!
      expect(locator.episode_title).to eq 'High Sparrow'
    end

    after :all do
      WhereTo.reset
    end

  end

end
