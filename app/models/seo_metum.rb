class SeoMetum < ActiveRecord::Base
  attr_accessible :seo_meta_type, :browser_title, :meta_description,
                  :meta_keywords
end