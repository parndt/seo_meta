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
  end

  class Engine < ::Rails::Engine

  end

  autoload :InstanceMethods, File.expand_path('../seo_meta/instance_methods', __FILE__)

end

def is_seo_meta(options = {})
  if included_modules.exclude?(::SeoMeta::InstanceMethods)
    # Let the base know about SeoMetum
    has_one :seo_meta, :class_name => 'SeoMetum',
            :foreign_key => :seo_meta_id, :dependent => :destroy,
            :conditions => {:seo_meta_type => self.name}

    # Let SeoMetum know about the base
    ::SeoMetum.send :belongs_to, self.name.underscore.gsub('/', '_').to_sym,
                    :class_name => self.name

    # Include the instance methods.
    self.send :include, ::SeoMeta::InstanceMethods

    # Ensure that seo_meta is saved after the model is saved.
    after_save :save_meta_tags!
  end

  # Delegate both the accessor and setters for the fields to :seo_meta
  fields = ::SeoMeta.attributes.keys
  fields = fields.reject{|field|
    self.column_names.map(&:to_sym).include?(field)
  } if self.table_exists?
  fields = fields.map{|a| [a, :"#{a}="]}.flatten

  fields << {:to => :seo_meta}
  delegate *fields
end