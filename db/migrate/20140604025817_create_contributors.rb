class CreateContributors < ActiveRecord::Migration
  def change
    create_table :contributors do |t|
      t.belongs_to :article
      t.belongs_to :user
      t.timestamps
    end
  end
end
