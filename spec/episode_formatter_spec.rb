require 'spec_helper'

describe WhereTo::EpisodeFormatter do

  before do
    @options = {}
    @options[:series_title] = 'series title'
    @options[:season_number] = 2
    @options[:episode_title] = 'episode title'
    @options[:episode_number] = 3
    @formatter = WhereTo::EpisodeFormatter.new @options
  end

  it 'requires a series title' do
    @formatter.series_title = nil
    expected_message = 'A series title is required to format an episode title.'
    expect { @formatter.format! }.to raise_error(RuntimeError, expected_message)
  end

  it 'requires a season number' do 
    @formatter.season_number = nil
    expected_message = 'A season number is required to format an episode title.'
    expect { @formatter.format! }.to raise_error(RuntimeError, expected_message)
  end

  it 'requires an episode title' do
    @formatter.episode_title = nil
    expected_message = 'An episode title is required to format an episode title.'
    expect { @formatter.format! }.to raise_error(RuntimeError, expected_message)
  end

  it 'requires an episode number' do
    @formatter.episode_number = nil
    expected_message = 'An episode number is required to format an episode title.'
    expect { @formatter.format! }.to raise_error(RuntimeError, expected_message)
  end

  it 'correctly formats episode titles' do
    expect(@formatter.format!).to eq 'series.title.S02E03.episode.title.mkv'
  end

  it 'automatically downcases series title' do
    @formatter.series_title = 'SERIES TITLE'
    expect(@formatter.format!).to eq 'series.title.S02E03.episode.title.mkv'
  end

  it 'automatically downcases episode title' do
    @formatter.episode_title = 'EPISODE TiTLE' #annoying
    expect(@formatter.format!).to eq 'series.title.S02E03.episode.title.mkv'
  end

  it 'honors custom extensions' do
    @formatter.extension = '.avi'
    expect(@formatter.format!).to eq 'series.title.S02E03.episode.title.avi'
  end 

  it 'will include quality if it is specified' do
    @formatter.quality = '720p'
    expect(@formatter.format!).to eq 'series.title.S02E03.episode.title.720p.mkv'
  end

end