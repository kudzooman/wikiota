class Article < ActiveRecord::Base
  belongs_to :user
  has_many :contributors, through: :user


  default_scope { order('created_at DESC') }
end
