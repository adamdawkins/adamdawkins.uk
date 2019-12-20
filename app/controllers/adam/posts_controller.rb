module Adam
  class PostsController < AdamController
    def index
      @posts = Post.all.order(updated_at: :desc)
    end

    def show
      @post = Post.find(params[:id])
      redirect_to "/adam/#{@post.type.downcase.pluralize}/#{@post.id}"
    end
  end
end
