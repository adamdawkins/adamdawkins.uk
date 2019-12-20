module Adam
  class SyndicatesController < AdamController
    def create
      @post = Post.find(params[:post_id])
      @post.syndicates.create(syndicate_params)
      redirect_to_post
    end

    def destroy
      @syndicate = Syndicate.find(params[:id])
      @post = @syndicate.post
      @syndicate.destroy
      redirect_to_post
    end

    private

    def syndicate_params
      params.require(:syndicate).permit(:silo_id, :url)
    end

    def redirect_to_post
      redirect_to(adam_post_path(@post)) and return
    end
  end
end
