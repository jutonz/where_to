require "bundler/gem_tasks"
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

task default: :spec

namespace :parallel do
  task :spec do
    sh "parallel_rspec spec/"
  end
end

task :watch do
  folders_to_watch = 'bin lib spec'
  action_on_change = 'bundle exec rake'
  begin 
    gem 'filewatcher'
    sh "filewatcher '#{folders_to_watch}' '#{action_on_change}'"
  rescue Gem::LoadError
    puts 'You need to have the filewatcher gem installed to perform this task.'
    puts 'Install with \'gem install filewatcher\''
  end
end
