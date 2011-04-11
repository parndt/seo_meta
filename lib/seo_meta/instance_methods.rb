module SeoMeta
  module InstanceMethods

    class << self
      def included(base)
        # This has to be introduced using module_eval because it overrides something.
        base.module_eval do
          def seo_meta_with_build
            seo_meta_without_build || build_seo_meta_tags
          end
          alias_method_chain :seo_meta, :build

          def attributes
            super.merge(seo_meta_attributes)
          end

          def attributes=(attributes, *args)
            attributes.update(seo_meta_attributes)
            super
          end

          def update_attributes(attributes, *args)
            attributes.update(seo_meta_attributes)
            super
          end
        end
      end
    end

    def seo_meta_attributes
      ::SeoMeta.attributes.keys.inject({}) { |attrs, name|
        attrs.merge(name.to_s => send(name))
      }
    end

  protected
    def build_seo_meta_tags
      @seo_meta ||= ::SeoMetum.new :seo_meta_type => self.class.name
    end

    def save_meta_tags
      seo_meta.seo_meta_id ||= self.id
      seo_meta.save
    end
  end
end