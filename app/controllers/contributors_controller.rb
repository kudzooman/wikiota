class ContributorsController < ApplicationController

  def new
    @contributor = Contributor.new
  end

  def create
    @article = Article.find(contributor_params[:article_id])
    @contributor = @article.contributors.build(contributor_params)

    if @contributor.save

    end
        redirect_to edit_article_path @article
  end

  def destroy
    @article = Article.friendly.find(params[:article_id])  
    @contributor = @article.contributors.find(params[:id])

    if @contributor.destroy
      
    end

    redirect_to edit_article_path(@article)
  
  end
    

  def contributor_params
    params.require(:contributor).permit(:article_id, :user_id)
  end
end
