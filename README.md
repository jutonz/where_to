# WhereTo 
[![Build Status](https://travis-ci.org/jutonz/where_to.svg)](https://travis-ci.org/jutonz/where_to)
[![Coverage Status](https://coveralls.io/repos/jutonz/where_to/badge.svg?branch=master)](https://coveralls.io/r/jutonz/where_to?branch=master)

This gem helps you maintain a directory sturucture for your mediafiles. For example, if you specify the following about a set of video files:  
* Series title: Game of Thrones
* Season: 5
* Season airdate: 2015  

This program tells you that they should be located in a folder called `Game of Thrones/Season 5 (2015)/`. Of course you can customize this to match whatever file structure you prefer.

If you specify some more data:
* Episode title: What a great episode
* Episode number: 3

The program will also tell you that the episode should be called `game.of.thrones.S05E03.what.a.great.episode.mkv`

## Installation

Add this line to your application's Gemfile:

```ruby
gem where_to, git: 'https://github.com/jutonz/where_to'
```

And then execute:

    $ bundle

## Usage

```ruby
require 'where_to'

# Specify data one at a time
locator = WhereTo::Locator.new 
locator.series_title = 'Game of Thrones'
locator.season = 5
locator.season_airdate = 2015
locator.locate # WhereTo::Location object with 'Game of Thrones/Season 5 (2015)/'

# Specify data in a batch
data = {}
data[:series_title] = 'Game of Thrones'
data[:season] = 5
data[:season_airdate] = 2015
locator = WhereTo::Locator.new data
locator.locate

# Specify episode info
data = {}
data[:series_title] = 'Game of Thrones'
data[:season] = 5
data[:season_airdate] = 2015
data[:episode_title] = 'best episode ever'
data[:episode_number] = 3
locator = WhereTo::Locator.new data
location = locator.locate
location.folder # => Game of Thrones/Season 5 (2015)
location.filename # => game.of.thrones.S05E02.best.episode.ever.mkv

# You can specify custom file extensions
locator.episode_extension = '.mp4'
locator.locate.filename # => game.of.thrones.S05E02.best.episode.ever.mp4

# And if you like you can specify a video quality
locator.episode_quality = '720p'
locator.locate.filename # => game.of.thrones.S05E02.best.episode.ever.720p.mkv
```

## Custom Formats
Specify custom formats by modifying `format.yml`.  
The default is `"%series_title/Season %season_number (%season_airdate)/"`, but in theory any combination works.

Right now you can't change the episode filename format, but we're working on it!

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/jutonz/where_to/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
