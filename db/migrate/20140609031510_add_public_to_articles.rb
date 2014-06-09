class AddPublicToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :public, :boolean, default: true
  end
end
