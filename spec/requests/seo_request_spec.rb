require 'spec_helper'

module SeoMeta
  describe HomeController do

    context "SeoMetum for path" do

      let(:path) { '/testing?b=1&d=1&c=1' }

      let(:seo_browser_title) { "[SEO META] Testing URL" }
      let(:seo_for_spec) { SeoMetum.create! :path => path, :browser_title => seo_browser_title }


      before :each do
        seo_for_spec
        SeoMetum.ignored_path_params = ["a"]
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

      context "when accessing by the same path with some ignored param" do


        let(:visited_path) { "/testing?a=1&b=1&d=1&c=1" }

        it("should have the SEO Info") do
          within(".seo.title") do
            page.should have_content(seo_browser_title)
          end
        end

      end

      context "when accessing by the same path with params sorted" do


        let(:visited_path) { "/testing?b=1&c=1&d=1" }

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
