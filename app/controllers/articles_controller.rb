class ArticlesController < ApplicationController
  def index
    @articles = Article.all
    authorize @articles
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
    authorize @article
  end

  def create
    @article = current_user.articles.build(article_params)
      authorize @article
      if @article.save
        redirect_to @article
      else
        render :new
      end
  end

  def edit
    @article = Article.find(params[:id])
    authorize @article
  end

  def update
    @article = Article.find(params[:id])
    if @article.update_attributes(article_params)
      authorize @article
      flash[:notice] = "Article was updated"
      redirect_to @article
    else
      flash[:error] = "There was an error saving the article. Please try again."
      render :edit
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :body)
  end

end
