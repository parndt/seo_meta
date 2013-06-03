module SeoMeta
  module InstanceControllerMethods

    class << self
      def included(base)
        base.class_eval do

          before_filter :set_seo

          def set_seo
            @seo = SeoMetum.find_by_sanitized_path(request.fullpath)
            @seo ||= SeoMetum.new :path => request.fullpath
          end
        end
      end
    end
  end
end
