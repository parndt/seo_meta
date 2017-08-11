require 'rails'

module SeoMeta

  class << self
    def attributes
      @@attributes ||= {
        :browser_title => :string,
        :meta_description => :text
      }
    end
  end

  class Engine < ::Rails::Engine
    engine_name 'seo_meta' if Rails.version.to_s >= '3.1.0'
  end

  autoload :InstanceMethods, File.expand_path('../seo_meta/instance_methods', __FILE__)
end

def is_seo_meta(options = {})
  if included_modules.exclude?(::SeoMeta::InstanceMethods)
    # Let the base know about SeoMetum
    has_one_options = {
      :class_name => 'SeoMetum',
      :foreign_key => :seo_meta_id,
      :dependent => :destroy
    }.merge(options.slice(:class_name, :foreign_key, :dependent))

    if ActiveRecord::VERSION::STRING >= '4.0.0'
      has_one :seo_meta, proc { where(:seo_meta_type => self.name) }, has_one_options
    else
      has_one :seo_meta, {:conditions => {:seo_meta_type => self.name}}.merge(has_one_options)
    end

    # Let SeoMetum know about the base
    if ActiveRecord::VERSION::STRING >= '5.0.0'
      ::SeoMetum.send :belongs_to, self.name.underscore.gsub('/', '_').to_sym,
                      class_name: self.name, optional: true
    else
      ::SeoMetum.send :belongs_to, self.name.underscore.gsub('/', '_').to_sym,
                      class_name: self.name
    end

    # Include the instance methods.
    self.send :include, ::SeoMeta::InstanceMethods

    # Ensure that seo_meta is saved after the model is saved.
    after_save :save_meta_tags!
  end

  # Delegate both the accessor and setters for the fields to :seo_meta
  fields = ::SeoMeta.attributes.keys.map{|a| [a, :"#{a}="]}.flatten

  fields << {:to => :seo_meta}
  delegate *fields
end
