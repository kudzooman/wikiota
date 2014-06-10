class ArticlesController < ApplicationController
  def index
    @search = Article.search do
     fulltext params[:search]
    end

    @articles = @search.results
    # @articles = policy_scope(Article)
     #@articles = Article.visible_to(current_user)
    #authorize @articles
  end

  def show
    @article = Article.friendly.find(params[:id])
    if request.path != article_path(@article)
      redirect_to @article, status: :moved_permanently
    end
    authorize @article
  end

  def new
    @article = Article.new
    authorize @article
  end

  def create
    @article = current_user.articles.build(article_params)
      authorize @article
      if @article.save!
        redirect_to @article
      else
        render :new
      end
    @article.user = current_user
  end

  def edit
    @article = Article.friendly.find(params[:id])
    @users = User.all - [current_user, @article.user]
    @contributor = Contributor.new
    authorize @article
  end

  def update
    @article = Article.friendly.find(params[:id])
    authorize @article
    if @article.update_attributes(article_params)
      flash[:notice] = "Article was updated"
      redirect_to @article
    else
      flash[:error] = "There was an error saving the article. Please try again."
      render :edit
    end
  end

  def destroy
    @article = Article.find(params[:id])
    name = @article.name

    authorize @article
    if @article.destroy
      flash[:notice] = "\"#{name}\" is gone forever."
    else
      flash[:error] = "Something went wrong. Try again."
      render :show
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :body)
  end

end
