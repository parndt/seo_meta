Gem::Specification.new do |s|
  s.platform          = Gem::Platform::RUBY
  s.name              = 'seo_meta'
  s.authors           = ['Philip Arndt']
  s.homepage          = 'https://github.com/parndt/seo_meta'
  s.email             = 'gems@p.arndt.io'
  s.version           = '3.1.0'
  s.description       = 'SEO Meta tags plugin for Ruby on Rails'
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
  s.add_dependency 'railties', '>= 5.0.0'

  s.cert_chain = [File.expand_path('certs/parndt.pem', __dir__)]
  if $PROGRAM_NAME =~ /gem\z/ && ARGV.include?('build') && ARGV.include?(__FILE__)
    s.signing_key = File.expand_path('~/.ssh/gem-private_key.pem')
  end
end
