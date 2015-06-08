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
      expect { @tvdb.lookup! }.to raise_error(RuntimeError, 'A series title is required to lookup episode information')
    end

    it 'requires a season number' do
      @tvdb.season = nil
      expect{ @tvdb.lookup! }.to raise_error(RuntimeError, 'A season number is required to lookup episode information')
    end

    it 'requires an episode number' do
      @tvdb.episode_number = nil
      expect{ @tvdb.lookup! }.to raise_error(RuntimeError, 'An episode number is required to lookup episode information')
    end
  end
end