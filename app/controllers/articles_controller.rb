class ArticlesController < ApplicationController
  def index
    @articles = Article.all.published
  end
end
