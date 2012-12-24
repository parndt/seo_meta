class AddPathToSeoMeta < ActiveRecord::Migration
  def change
    add_column :seo_meta, :path, :string
  end
end
