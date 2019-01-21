class Adam::ArticlesController < AdamController
  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    @article.publish if params[:publish]

    if @article.save
      TwitterService.post(@article) if params[:publish] && params[:send_to_twitter]
      redirect_to adam_articles_path, notice: "Article created successfully"
    end
  end

  def show
    set_article
  end

  def publish
    set_article
    if @article.publish!
      redirect_to long_post_path(@article.params), notice: "Article published successfully"
    end
  end

  private

    def set_article
      @article = Article.find(params[:id])
    end

    def article_params
      params.require(:article).permit(:title, :content)
    end
end
