module SeoMeta
  module InstanceMethods

    class << self
      def included(base)
        # This has to be introduced using module_eval because it overrides something.
        base.module_eval do
          def seo_meta
            find_seo_meta_tags || build_seo_meta_tags
          end

          # Allow attributes supplied to override the current seo_meta_attributes.
          def attributes
            seo_meta_attributes.merge(super)
          end

          def attributes_equals(attributes, *args)
            seo_meta_attributes.merge(attributes)
            super
          end

          alias_method :attributes_equals, :attributes=
        end
      end
    end

    def seo_meta_attributes
      ::SeoMeta.attributes.keys.inject({}) { |attrs, name|
        attrs.merge(name.to_s => send(name))
      }
    end

  protected
    def find_seo_meta_tags
      @seo_meta ||= ::SeoMetum.where(:seo_meta_type => self.class.name,
                                     :seo_meta_id => self.id).first
    end

    def build_seo_meta_tags
      @seo_meta ||= ::SeoMetum.new :seo_meta_type => self.class.name
    end

    def save_meta_tags!
      seo_meta.seo_meta_id ||= self.id unless seo_meta.persisted?
      seo_meta.save
    end
  end
end
