# WhereTo [![Build Status](https://travis-ci.org/jutonz/where_to.svg)](https://travis-ci.org/jutonz/where_to)

This gem helps you maintain a directory sturucture for your mediafiles. For example, if you specify the following about a set of video files:  
* Show title: Game of Thrones
* Season: 5
* Season airdate: 2015  

This program tells you that they should be located in a folder called `Game of Thrones/Season 5 (2015)/`. Of course you can customize this to match whatever file structure you prefer.

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
locator.title = 'Game of Thrones'
locator.season = 5
locator.season_airdate = 2015
locator.locate # returns a WhereTo::Location object with 'Game of Thrones/Season 5 (2015)/'

# Specify data in a batch
data = {}
data[:title] = 'Game of Thrones'
data[:season] = 5
data[:season_airdate] = 2015
locator = WhereTo::Locator.new data
locator.locate
```

## Custom Formats
Specify custom formats by modifying `format.yml`  
The default is `"%series_title/Season %season_number (%season_airdate)/"`, but in theory any combination works.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/jutonz/where_to/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
