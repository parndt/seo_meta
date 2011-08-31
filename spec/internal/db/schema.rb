# Defined based on the migrations and the dummy spec model.

::ActiveRecord::Schema.define(:version => 20110329222114) do

  create_table 'seo_meta', :force => true do |t|
    t.integer 'seo_meta_id'
    t.string 'seo_meta_type'

    t.string 'browser_title'
    t.string 'meta_keywords'
    t.text 'meta_description'

    t.timestamps
  end

  add_index 'seo_meta', 'id'
  add_index 'seo_meta', ['seo_meta_id', 'seo_meta_type']

  create_table 'seo_meta_dummy_for_specs', :force => true do |t|
    t.timestamps
  end
end