class AddRobotsTagsToSeoMeta < ActiveRecord::Migration
  def change
    add_column :seo_meta, :noindex, :boolean, :default => false
    add_column :seo_meta, :nofollow, :boolean, :default => false
  end
end
