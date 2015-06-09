require 'spec_helper'

describe WhereTo::TVDB do

  describe 'validation' do
    before :each do
      params = {}
      params[:series_title]   = 'Game of Thrones'
      params[:season]         = 5
      params[:episode_number] = 2
      @tvdb = WhereTo::TVDB.new params
    end

    it 'requires a series name' do
      @tvdb.series_title = nil
      expect { @tvdb.validate! }.to raise_error(RuntimeError, 'A series title is required to lookup episode information')
    end

    it 'requires a season number' do
      @tvdb.season = nil
      expect{ @tvdb.validate! }.to raise_error(RuntimeError, 'A season number is required to lookup episode information')
    end

    it 'requires an episode number' do
      @tvdb.episode_number = nil
      expect{ @tvdb.validate! }.to raise_error(RuntimeError, 'An episode number is required to lookup episode information')
    end

    it 'returns true when all is well' do
      expect(@tvdb.validate!).to be true
    end
  end

  describe 'lookup' do
    before :each do
      params = {}
      params[:series_title]   = 'Game of Thrones'
      params[:season]         = 5
      params[:episode_number] = 2
      @tvdb_bad_key = WhereTo::TVDB.new params

      WhereTo.configure do |config|
        config.tvdb_api_key = ENV['TVDB_API_KEY']
      end
      @tvdb_good_key = WhereTo::TVDB.new params
    end

    after :each do
      WhereTo.reset
    end

    it 'validates beforehand' do
      expect{ @tvdb_good_key.validate! }.to_not raise_error
    end

    it 'compliains if your TVDB API key was not set' do
      expect{ @tvdb_bad_key.lookup! }.to raise_error(RuntimeError, 'You need to configure your TVDB API key before looking up episode information')
    end

    it 'gets episode title' do
      expect(WhereTo.configuration.tvdb_api_key).to eq ENV['TVDB_API_KEY']
      expect(@tvdb_good_key.api_key).to eq ENV['TVDB_API_KEY']
      @tvdb_good_key.lookup!
      expect(@tvdb_good_key.episode_title).to eq 'The House of Black and White'
    end

    it 'gets season airdate' do
      @tvdb_good_key.lookup!
      expect(@tvdb_good_key.season_airdate).to be 2015
    end

    it 'returns a hash of updated values' do
      results = @tvdb_good_key.lookup!
      expect(results[:episode_title]).to eq 'The House of Black and White'
    end

  end

end