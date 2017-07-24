# -*- encoding: utf-8 -*-
$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)
require 'rubygems'
require 'bundler/setup'

task :default => :spec

task :spec do
  %w(3.0 3.1 3.2 4.0 4.2 5.0 5.1).each do |rails_version|
    [
      'bundle update',
      'bundle exec rspec spec'
    ].each do |task|
      command = [
        "BUNDLE_GEMFILE='gemfiles/Gemfile.rails-#{rails_version}.rb'",
        task
      ].join(' ')
      puts "\n" + command
      system command
    end
  end
  puts "\n"
end
