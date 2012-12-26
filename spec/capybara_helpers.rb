Capybara::Helpers.instance_eval do
    # Regular Capybara Helpers introduced a bug on Ruby 1.8.7 (https://github.com/jnicklas/capybara/issues/916) with unicode whitespaces so we ignore unicode whitespaces until it's fixed
    def normalize_whitespace(text)
      text.to_s.gsub(/\s+/, ' ').strip
    end
end
