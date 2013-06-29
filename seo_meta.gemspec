Gem::Specification.new do |s|
  s.platform          = Gem::Platform::RUBY
  s.name              = 'seo_meta'
  s.authors           = ['Philip Arndt']
  s.homepage          = 'http://philiparndt.name'
  s.email             = 'parndt@gmail.com'
  s.version           = '1.4.0'
  s.description       = 'SEO Meta tags plugin for Ruby on Rails'
  s.date              = '2012-11-28'
  s.summary           = 'SEO Meta tags plugin'
  s.require_paths     = %w(lib)
  s.files             = Dir['lib/**/*', 'db/**/*', 'app/**/*', 'config/**/*', '*.md']
  s.license           = %q{MIT}

  s.add_development_dependency 'combustion'
  s.add_development_dependency 'rspec'
  unless defined?(JRUBY_VERSION)
    s.add_development_dependency 'sqlite3'
  else
    s.add_development_dependency 'activerecord-jdbcsqlite3-adapter'
  end
  s.add_dependency 'railties', '>= 3.0.0'
end
