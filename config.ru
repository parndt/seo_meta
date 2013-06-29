require 'rubygems'
require 'bundler'

Bundler.require :default, :development, :test

Combustion.initialize! :active_record
run Combustion::Application
