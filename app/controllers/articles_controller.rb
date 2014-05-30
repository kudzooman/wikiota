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
    @article = current_user.articles.build(params.require(:article).permit(:title, :body))
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
    if @article.update_attributes(params.require(:article).permit(:title, :body))
      authorize @article
      redirect_to @article
    else
      render :edit
    end
  end

end
