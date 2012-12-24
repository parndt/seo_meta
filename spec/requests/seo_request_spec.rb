require 'spec_helper'

module SeoMeta
  describe HomeController do

    context "SeoMetum for path" do

      let(:path) { '/testing' }

      let(:seo_browser_title) { "[SEO META] Testing URL" }
      let(:seo_for_spec) { SeoMetum.create! :path => path, :browser_title => seo_browser_title }


      before :each do
        seo_for_spec
        visit(visited_path);
      end

      subject {  page }

      context "when accessing by the same path" do

        let(:visited_path) { path }

        it("should have the SEO Info") do
          within(".seo.title") do
            page.should have_content(seo_browser_title)
          end
        end

      end


      context "when accessing other the same path" do

        let(:visited_path) { "/this-path-has-no-seo" }

        it("should not have SEO Info but not crash") do
          within(".seo.title") do
            page.should_not have_content(seo_browser_title)
          end
        end

      end

    end

  end
end
