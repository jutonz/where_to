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
      @tvdb = WhereTo::TVDB.new params
    end

    it 'validates beforehand' do
      expect{ @tvdb.lookup! }.to_not raise_error
    end

    it 'gets episode title' do
      @tvdb.lookup!
      expect(@tvdb.episode_title).to eq 'The House of Black and White'
    end


  end

end