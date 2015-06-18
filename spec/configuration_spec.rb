require 'spec_helper'

describe WhereTo do

  describe '#configure' do
    let(:format)  { 'wow/what/a/great/directory/structure' }
    let(:api_key) { '1337hax0r' }

    after { WhereTo.reset }

    it 'folder_format has a reasonable default' do
      expect(WhereTo.configuration.folder_format).to \
        eq "%series_title/Season %season_number (%season_airdate)/"
    end

    it 'allows updating of folder_format' do
      WhereTo.configure { |config| config.folder_format = format }
      expect(WhereTo.configuration.folder_format).to eq format
    end

    it 'allows updating of tvdb_api_key' do
      WhereTo.configure { |config| config.tvdb_api_key = api_key }
      expect(WhereTo.configuration.tvdb_api_key).to eq api_key
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
