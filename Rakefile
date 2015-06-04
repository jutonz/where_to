require "bundler/gem_tasks"
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

task default: :spec

task :watch do
  begin 
    gem 'filewatcher'
    sh "filewatcher 'bin lib spec' 'bundle exec rake'"
  rescue Gem::LoadError
    puts 'You need to have the filewatcher gem installed to perform this task.'
    puts 'Install with \'gem install filewatcher\''
  end
end