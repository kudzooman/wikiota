class Article < ActiveRecord::Base
  belongs_to :user
  has_many :contributors, through: :user
end
