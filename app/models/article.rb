class Article < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: [:slugged, :history]

  #def should_generate_new_friendly_id?
  #  new_record?
  #end

  belongs_to :user
  has_many :contributors, through: :user


  default_scope { order('created_at DESC') }
end
