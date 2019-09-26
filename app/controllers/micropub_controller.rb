class MicropubController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    @note = Note.create(content: params[:content])
    redirect_to long_post_path(@note.params), status: :created if @note.publish!
  end
end
