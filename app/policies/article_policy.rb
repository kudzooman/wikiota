class ArticlePolicy < ApplicationPolicy
  class Scope < Struct.new(:user, :scope)
    def resolve
      if user.role?(:admin)
        scope.all
      elsif user.role?(:premium)
        articles = scope.all
        articles.map{|a| a.public? || a.user == user}
        # only gets get see public article, private articles user created, private articles user is a contributor for
      else
        # gets to see public articles, private articles user is a contributor for
      end
    end
  end

  def index?
    true
  end
end