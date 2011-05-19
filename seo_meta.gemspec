Gem::Specification.new do |s|
  s.platform          = Gem::Platform::RUBY
  s.name              = 'seo_meta'
  s.authors           = ['Philip Arndt']
  s.homepage          = 'http://philiparndt.name'
  s.email             = 'parndt@gmail.com'
  s.version           = '1.1.0'
  s.description       = 'SEO Meta tags plugin for Ruby on Rails'
  s.date              = '2011-05-19'
  s.summary           = 'SEO Meta tags plugin'
  s.require_paths     = %w(lib)
  s.files             = Dir['lib/**/*', 'db/**/*', 'app/**/*', '*.md']

  s.add_dependency 'refinerycms-generators', '~> 1.0.1'
end
