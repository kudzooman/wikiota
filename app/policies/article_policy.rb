class ArticlePolicy < ApplicationPolicy
  class Scope < Struct.new(:user, :scope)
    def resolve
      if user.role?(:admin)
        scope.all
      elsif user.role?(:premium)
        articles = scope.all
        #articles.map{|a| a.public? || a.user == user || a.users.include?(user) }
        # only gets get see public article, private articles user created, private articles user is a contributor for
      else
        scope.where(:public => true || article.user.include?(user) )
        # ??? same as, scope :visible_to, ->(user) {user ? all : where(public: true) } ???
        # gets to see public articles, private articles user is a contributor for
      end
    end
  end

  def update?
    user.admin? || user.role?
  end

  def index?
    true
  end

  def show?
    record.public? || user.present?
  end
end