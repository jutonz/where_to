require 'spec_helper'

describe WhereTo do
  it 'has a version number' do
    expect(WhereTo::VERSION).not_to be nil
  end

  it 'accepts episode info in the fromat of SxxExx' do
    location = WhereTo.locate series: 'Game of Thrones', episode: 'S05E01'
    expect(location.folder).to eq '/Game of Thrones/Season 5 (2015)'

  end
end
