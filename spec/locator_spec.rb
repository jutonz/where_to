require 'spec_helper'

describe WhereTo::Locator do

  describe 'validation' do
    before do
      @options = {}
      @options[:title]          = 'Show title'
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

    it 'remembers an episode title' do
      title = 'amazing title'
      @locator.title = title
      expect(@locator.title).to be title
    end

    it 'remembers a season number' do
      season_number = 2
      @locator.season = season_number
      expect(@locator.season).to be season_number
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
      @options[:title]          = 'Show title'
      @options[:season]         = 2
      @options[:airdate]        = Date.today
      @options[:season_airdate] = 2015

      locator = WhereTo::Locator.new @options

      expect(locator.title).to eq 'Show title'
      expect(locator.season).to eq 2
      expect(locator.airdate).to eq Date.today
      expect(locator.season_airdate).to eq 2015
    end

  end

  describe 'locating' do

    it 'can locate shows with a title, season, and season airdate' do
      options = {}
      options[:title]          = 'Game of Thrones'
      options[:season]         = 5
      options[:season_airdate] = 2015

      locator = WhereTo::Locator.new options
      expect(locator.locate).to eq 'Game of Thrones/Season 5 (2015)/'
    end

    it 'returns a location object' do
      options = {}
      options[:title]          = 'Game of Thrones'
      options[:season]         = 5
      options[:season_airdate] = 2015

      locator = WhereTo::Locator.new options
      expect(locator.locate.class).to eq WhereTo::Location
    end

  end

end