class SeoMetum < ActiveRecord::Base
  unless ::SeoMetum.table_exists?
    warn "[seo_meta] Table does not exist, please create #{::SeoMetum.table_name}."
    warn "[seo_meta] See https://github.com/parndt/seo_meta#readme for instructions."
  end

  ::SeoMeta.bases.each do |base|
    belongs_to base.name.underscore.gsub('/', '_').to_sym,
      :class_name => base.name
  end

  attr_accessible :seo_meta_type, :browser_title, :meta_description,
                  :meta_keywords
end
