module Adam
  class ArticlesController < AdamController
    before_action :set_article, only: %i[show publish edit update]

    def show; end

    def index
      @articles = Article.all
    end

    def new
      @article = Article.new
    end

    def edit; end

    def update
      @article.update(article_params)
      redirect_to adam_article_path(@article),
                  notice: 'Article updated successfully'
    end

    def create
      @article = Article.new(article_params)

      @article.publish if params[:publish]

      return unless @article.save

      TwitterService.post(@article) if params[:publish] &&
                                       params[:send_to_twitter]

      redirect_to adam_articles_path, notice: 'Article created successfully'
    end

    def publish
      return unless @article.publish!

      redirect_to long_post_path(@article.params),
                  notice: 'Article published successfully'
    end

    private

    def set_article
      @article = Article.find(params[:id])
    end

    def article_params
      params.require(:article).permit(:title, :content, :published_at)
    end
  end
end
