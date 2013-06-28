class SeoMetaGenerator < Rails::Generators::Base
  def rake_db
    rake("seo_meta:install:migrations")
  end
end
