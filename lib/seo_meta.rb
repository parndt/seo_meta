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

  autoload :ClassMethods, File.expand_path('../seo_meta/class_methods', __FILE__)
  autoload :InstanceMethods, File.expand_path('../seo_meta/instance_methods', __FILE__)

end

def is_seo_meta(options = {})
  if ::SeoMetum.table_exists?
    # Let the base know about SeoMetum
    has_one :seo_meta, :class_name => 'SeoMetum',
            :foreign_key => :seo_meta_id, :dependent => :destroy,
            :conditions => {:seo_meta_type => self.name}

    # Let SeoMetum know about the base
    ::SeoMetum.send :belongs_to, self.name.underscore.gsub('/', '_').to_sym,
                    :class_name => self.name

    # Include the instance methods and extend with the class methods.
    self.send :include, ::SeoMeta::InstanceMethods
    extend ::SeoMeta::ClassMethods

    # Ensure that seo_meta is saved after the model is saved.
    after_save :save_meta_tags!

    # Delegate both the accessor and setters for the fields to :seo_meta
    fields = ::SeoMeta.attributes.keys.reject{|field|
      self.column_names.map(&:to_sym).include?(field)
    }.map{|a| [a, :"#{a}="]}.flatten
    fields << {:to => :seo_meta}

    delegate *fields
  else
    warn "[seo_meta] Table does not exist, please create #{::SeoMetum.table_name}."
    warn "[seo_meta] See https://github.com/parndt/seo_meta#readme for instructions."
  end
end
