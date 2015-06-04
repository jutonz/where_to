require 'spec_helper'

describe WhereTo::Location do

  describe 'for an individual file' do
    before :all do
      @location = WhereTo::Location.new '/test/dir/file.mp3' 
    end

    it 'remembers a containing folder' do 
      expect(@location.folder).to eq '/test/dir/'
    end

    it 'remembers a filename' do
      expect(@location.filename).to eq 'file.mp3'
    end

    it 'can be eq to a string' do
      expect(@location).to eq '/test/dir/file.mp3'
    end
  end

  describe 'for a directory' do
    before :all do
      @location = WhereTo::Location.new '/test/dir'
    end

    it 'remembers a contianing folder' do
      expect(@location.folder).to eq '/test/dir/'
    end

    it 'has no filename' do
      expect(@location.filename).to eq ''
    end

    it 'can be eq to a string' do
      expect(@location).to eq '/test/dir'
    end
  end

end