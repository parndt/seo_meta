require 'rails'

module SeoMeta

  class << self
    def attributes
      @@attributes ||= {
        :browser_title => :string,
        :meta_keywords => :string,
        :meta_description => :text
      }
    end

    def bases
      @@bases ||= []
    end
  end

  class Engine < ::Rails::Engine

  end

  autoload :ClassMethods, File.expand_path('../seo_meta/class_methods', __FILE__)
  autoload :InstanceMethods, File.expand_path('../seo_meta/instance_methods', __FILE__)

end

def is_seo_meta(options = {})
  # Let the base know about SeoMetum
  has_one :seo_meta, :class_name => 'SeoMetum',
          :foreign_key => :seo_meta_id, :dependent => :destroy,
          :conditions => {:seo_meta_type => self.name}

  # Let SeoMetum know about the base
  ::SeoMeta.bases << self

  # Include the instance methods and extend with the class methods.
  self.send :include, ::SeoMeta::InstanceMethods
  extend ::SeoMeta::ClassMethods

  # Ensure that seo_meta is saved after the model is saved.
  after_save :save_meta_tags!
end
