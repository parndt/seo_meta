class SeoMetum < ActiveRecord::Base
  attr_accessible :seo_meta_type, :browser_title, :meta_description, :path

  # These finders will find by the path after it's sanitized
  def self.find_by_sanitized_path path, ignored_path_params = []
    find_by_path(SeoMetum.sanitize_path(path, ignored_path_params))
  end

  def self.find_all_by_sanitized_path path, ignored_path_params = []
    find_all_by_path(SeoMetum.sanitize_path(path, ignored_path_params))
  end

  # This method gets a path and 'sanitizes it'. This means that all the params that we don't want (Google Analytics params, testing params...) are stripped out and params are sorted so '/en?a=1&b=1' and '/en?b=1&a=1' gets the same seo info
  def self.sanitize_path path, ignored_path_params = []
    path, params = path.split("?")
    if params.blank?
      path
    else
      # We split the params
      params = params.split('&')
      # And then get those ignored and remove them
      not_ignored_params = params.reject{|p| ignored_path_params.detect{|ignored| p.start_with?("#{ignored}=") || (p == ignored)}}

      not_ignored_params.blank? ? path : "#{path}?#{not_ignored_params.join('&')}"

    end

  end

end
