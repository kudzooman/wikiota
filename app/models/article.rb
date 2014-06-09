class Article < ActiveRecord::Base
  extend FriendlyId

  belongs_to :user

  has_many :contributors, dependent: :destroy # <- ??? is this right in case article is deleted ???
  has_many :users, through: :contributors

  friendly_id :title, use: [:slugged, :history]

  #def should_generate_new_friendly_id?
  #  new_record?
  #end

  scope :visible_to, ->(user) { user ? all : where(public: true) }

  searchable do
    text :title, :boost => 5
    text :body, :publish_month
  end

  def publish_month
   created_at.strftime("%B %Y")
  end

  default_scope { order('created_at DESC') }
end
