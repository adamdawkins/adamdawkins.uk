module Adam
  class RepostsController < AdamController
    def show
      @repost = Repost.find(params[:id])
    end

    def new
      @repost = Repost.new
    end

    def create
      @repost = Repost.create(repost_params)      

      if @repost.save
        redirect_to adam_repost_path(@repost)
      else
        render :new
      end
    end

    private

    def repost_params
      params.require(:repost).permit(:content, :repost_of)
    end
  end
end
