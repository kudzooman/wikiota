class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :contributors
  has_many :articles, through: :contributors

  scope :visible_to, ->(user) { user ? all : where(public: true) }

  searchable do
    text :name
  end

  def role?(base_role)
    role == base_role.to_s
  end

end
