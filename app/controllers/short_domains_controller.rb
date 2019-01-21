class ShortDomainsController < ApplicationController
  def post
    @post = Post.find(params[:id])
    redirect_to long_post_path(@post.params), host: ENV['FULL_URL']
  end
end
