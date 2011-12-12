class SeoMetaGenerator < Rails::Generators::Base
  def rake_db
    rake("refinery_seo_meta:install:migrations")
  end
end
