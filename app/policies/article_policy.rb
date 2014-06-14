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
    user.present? && (user.role?(:admin) || (record.user == user) || record.users.include?(user))
  end

  def edit?
    update?
  end

  def index?
    record.public? || update?
  end

  def show?
    record.public?
  end

  def destroy?
    user.present? && (record.user == user || user.role?(:admin) || user.role?(:moderator))
  end

end