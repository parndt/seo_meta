require 'rubygems'
require 'bundler'

def setup_environment
  # Configure Rails Environment
  ENV["RAILS_ENV"] ||= 'test'

  Bundler.require :default, :development

  require 'capybara_helpers'

  Combustion.initialize! :active_record, :action_controller

  require 'rspec/rails'
  require 'capybara/rspec'

  Rails.backtrace_cleaner.remove_silencers!

  Dir[File.expand_path('../support/*.rb', __FILE__)].each do |support|
    require support
  end

  RSpec.configure do |config|
    config.mock_with :rspec

    config.use_transactional_fixtures = true
  end
end

def each_run
end

# If spork is available in the Gemfile it'll be used but we don't force it.
unless (begin; require 'spork'; rescue LoadError; nil end).nil?
  Spork.prefork do
    # Loading more in this block will cause your tests to run faster. However,
    # if you change any configuration or code from libraries loaded here, you'll
    # need to restart spork for it take effect.
    setup_environment
  end

  Spork.each_run do
    # This code will be run each time you run your specs.
    each_run
  end
else
  setup_environment
  each_run
end

def capture_stdout(stdin_str = '')
  begin
    require 'stringio'
    $o_stdin, $o_stdout, $o_stderr = $stdin, $stdout, $stderr
    $stdin, $stdout, $stderr = StringIO.new(stdin_str), StringIO.new, StringIO.new
    yield
    {:stdout => $stdout.string, :stderr => $stderr.string}
  ensure
    $stdin, $stdout, $stderr = $o_stdin, $o_stdout, $o_stderr
  end
end
