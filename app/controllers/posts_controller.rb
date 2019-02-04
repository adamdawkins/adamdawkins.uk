class PostsController < ApplicationController
  before_action :set_published_date, only: :show
  def show
    @post = Post.where(published_at: @published_date.all_day, slug: params[:slug]).first
    
    if @post.is_reply?
      @original = TwitterService.fetch_original(@post.in_reply_to)
    end
    render "#{@post.type.downcase.pluralize}/show"
  end

  def index
    @posts = Post.published
    @posts_by_day = Post.published.group_by { |p| p.published_at.to_date }
  end

  private

    def set_published_date
      @published_date = Date.new(params[:year].to_i,
                                 params[:month].to_i,
                                 params[:day].to_i
                                )
    end
end
