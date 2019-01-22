class Adam::PostsController < AdamController
  def index
    @posts = Post.all.order(updated_at: :desc)
  end

  def show
    @post = Post.find(params[:id])
    @next_post = Post.published.next(@post)
    @previous_post = Post.published.previous(@post)
    redirect_to "/adam/#{@post.type.downcase.pluralize}/#{@post.id}"
  end
end
