class AddLastUserToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :last_user_id, :integer
  end
end
