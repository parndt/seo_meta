require 'refinerycms-generators'
require 'refinery/generators'

class SeoMetaGenerator < ::Refinery::Generators::EngineInstaller

  source_root File.expand_path('../../../', __FILE__)
  engine_name "seo_meta"

end
