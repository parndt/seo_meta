require 'spec_helper'

module SeoMeta
  class DummyForSpec < ActiveRecord::Base
    self.table_name = 'seo_meta_dummy_for_specs'

    is_seo_meta
  end
end

module SeoMeta
  describe DummyForSpec do
    let(:dummy_for_spec) { DummyForSpec.create }

    context 'responds to' do
      it 'meta_description' do
        dummy_for_spec.respond_to?(:meta_description).should be_true
      end

      it 'browser_title' do
        dummy_for_spec.respond_to?(:browser_title).should be_true
      end
    end

    context 'allows us to assign to' do
      it 'meta_description' do
        dummy_for_spec.meta_description = 'This is my description of the dummy_for_spec for search results.'
        dummy_for_spec.meta_description.should == 'This is my description of the dummy_for_spec for search results.'
      end

      it 'browser_title' do
        dummy_for_spec.browser_title = 'An awesome browser title for SEO'
        dummy_for_spec.browser_title.should == 'An awesome browser title for SEO'
      end
    end

    context 'allows us to update' do
      it 'meta_description' do
        dummy_for_spec.meta_description = 'This is my description of the dummy_for_spec for search results.'
        dummy_for_spec.save

        dummy_for_spec.reload
        dummy_for_spec.meta_description.should == 'This is my description of the dummy_for_spec for search results.'
      end

      it 'browser_title' do
        dummy_for_spec.browser_title = 'An awesome browser title for SEO'
        dummy_for_spec.save

        dummy_for_spec.reload
        dummy_for_spec.browser_title.should == 'An awesome browser title for SEO'
      end
    end

    context "SeoMetum for URL" do

      before :each do
        seo_for_spec
      end

      let(:seo_browser_title) { "[SEO META] Testing URL" }
      let(:seo_for_spec) { SeoMetum.create! :url => "/en/test-for-seo", :browser_title => seo_browser_title }

      subject { seo_for_spec }

      its(:browser_title) { should == seo_browser_title}

      context "when searched by the url" do

        let(:found_seo) { SeoMetum.find_by_url "/en/test-for-seo"}

        subject { found_seo }

        it "should find the SEO information" do
          seo_for_spec  == found_seo
        end

        its(:browser_title) { should == seo_browser_title}


      end

    end

  end
end
