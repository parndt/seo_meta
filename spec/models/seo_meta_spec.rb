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
        expect(dummy_for_spec).to respond_to(:meta_description)
      end

      it 'browser_title' do
        expect(dummy_for_spec).to respond_to(:browser_title)
      end
    end

    context 'allows us to assign to' do
      it 'meta_description' do
        dummy_for_spec.meta_description = 'This is my description of the dummy_for_spec for search results.'
        expect(dummy_for_spec.meta_description).to eq('This is my description of the dummy_for_spec for search results.')
      end

      it 'browser_title' do
        dummy_for_spec.browser_title = 'An awesome browser title for SEO'
        expect(dummy_for_spec.browser_title).to eq('An awesome browser title for SEO')
      end
    end

    context 'allows us to update' do
      it 'meta_description' do
        dummy_for_spec.meta_description = 'This is my description of the dummy_for_spec for search results.'
        dummy_for_spec.save

        dummy_for_spec.reload
        expect(dummy_for_spec.meta_description).to eq('This is my description of the dummy_for_spec for search results.')
      end

      it 'browser_title' do
        dummy_for_spec.browser_title = 'An awesome browser title for SEO'
        dummy_for_spec.save

        dummy_for_spec.reload
        expect(dummy_for_spec.browser_title).to eq('An awesome browser title for SEO')
      end
    end

  end
end
