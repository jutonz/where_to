require 'spec_helper'

describe WhereTo do

  describe '#configure' do 
    before :each do
      @format = 'wow/what/a/great/directory/structure'
      WhereTo.configure do |config|
        config.folder_format = @format
      end
    end

    it 'accepts a new configuration' do
      expect(WhereTo.configuration.folder_format).to eq @format
    end

    after :each do
      WhereTo.reset
    end

  end

  describe '#reset' do
    it 'resets the configuration' do
      default_format = WhereTo.configuration.folder_format

      WhereTo.configure do |config|
        config.folder_format = '/hello/i/am/bob'
      end

      expect(WhereTo.configuration.folder_format).to eq '/hello/i/am/bob'

      WhereTo.reset
      expect(WhereTo.configuration.folder_format).to eq default_format 
    end
  end

end