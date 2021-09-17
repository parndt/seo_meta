source 'http://rubygems.org'

gemspec :path => File.expand_path('../', __FILE__)

group :test do
  gem 'combustion', '~> 1.3'
  RAILS_VERSION = nil unless defined? RAILS_VERSION
  gem 'railties', RAILS_VERSION
  gem 'activerecord', RAILS_VERSION
end
