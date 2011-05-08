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
          def attributes_with_seo_meta
            seo_meta_attributes.merge(attributes_without_seo_meta)
          end

          alias_method_chain :attributes, :seo_meta

          def attributes_equals_with_seo_meta(attributes, *args)
            seo_meta_attributes.merge(attributes)
            attributes_equals_without_seo_meta
          end

          alias_method :attributes_equals, :attributes=
          alias_method_chain :attributes_equals, :seo_meta
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