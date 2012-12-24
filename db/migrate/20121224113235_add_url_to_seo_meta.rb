class AddUrlToSeoMeta < ActiveRecord::Migration
  def change
    add_column :seo_meta, :url, :string
  end
end
