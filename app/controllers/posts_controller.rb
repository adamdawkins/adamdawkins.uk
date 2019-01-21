class PostsController < ApplicationController
  before_action :set_published_date, only: :show
  def show
    @post = Post.where(published_at: @published_date.all_day, slug: params[:slug]).first

    render "#{@post.type.downcase.pluralize}/show"
  end

  private

    def set_published_date
      @published_date = Date.new(params[:year].to_i,
                                 params[:month].to_i,
                                 params[:day].to_i
                                )
    end
end