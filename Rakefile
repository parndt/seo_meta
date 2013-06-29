# -*- encoding: utf-8 -*-
$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)
require 'rubygems'
require 'bundler/setup'

task :default => :spec

task :spec do
  %w(3.0 3.1 3.2 4.0).each do |rails_version|
    bundle_gemfile = "BUNDLE_GEMFILE='gemfiles/Gemfile.rails-#{rails_version}.rb'"
    puts "\n" + (cmd = "#{bundle_gemfile} bundle exec rspec spec")
    system cmd
  end
  puts "\n"
end
