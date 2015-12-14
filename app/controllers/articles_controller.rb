class ArticlesController < ApplicationController

  layout 'articles'

  def index
    @article = Article.new()
  end

  private

  def article_params
    params.require(:post).permit(:title, :content, :public, :bootsy_image_gallery_id)
  end
end
