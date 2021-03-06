class Article < ActiveRecord::Base
  extend FriendlyId

  belongs_to :user

  has_many :contributors, dependent: :destroy # <- ??? is this right in case article is deleted ???
  has_many :users, through: :contributors

  friendly_id :title, use: [:slugged, :history]

  #def should_generate_new_friendly_id?
  #  new_record?
  #end

  default_scope { order('created_at DESC') }

  scope :visible_to, ->(user) { user ? all : where(public: true) }

  searchable do
    text :title, :boost => 5
    text :body, :publish_month
  end

  def last_user
    if self.last_user_id
      User.find(self.last_user_id)
    else
      nil
    end
  end

  def last_user=(user)
    self.last_user_id = user.id
  end

  def publish_month
   created_at.strftime("%B %Y")
  end

end
