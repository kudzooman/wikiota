class ArticlesController < ApplicationController
  def index
    @search = Article.search do
     fulltext params[:search]
     paginate(page: params[:page], per_page: 15)
    end
    @articles = @search.results
    #@articles = policy_scope(Article)
     #@articles = Article.visible_to(current_user)
  end

  def show
    @article = Article.friendly.find(params[:id])
    if request.path != article_path(@article)
      redirect_to @article, status: :moved_permanently
    end
  end

  def new
    @article = Article.new
    authorize @article
  end

  def create
    @article = Article.new(article_params)
      @article.user = current_user
      authorize @article
      puts @article.user
      if @article.save!
        redirect_to @article
      else
        render :new
      end
  end

  def edit
    @article = Article.friendly.find(params[:id])
    @users = User.all - [current_user, @article.user]
    @contributor = Contributor.new
    #authorize @article
  end

  def update
    @article = Article.friendly.find(params[:id])
    @article.last_user= current_user

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
    @article = Article.friendly.find(params[:id])
    title = @article.title

    authorize @article
    if @article.destroy
      flash[:notice] = "\"#{title}\" is gone forever."
    else
      flash[:error] = "Something went wrong. Try again."
      render :show
    end
    redirect_to articles_path
  end

  private

  def article_params
    params.require(:article).permit(:title, :body, :public)
  end

end
