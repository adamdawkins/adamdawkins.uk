class MicropubController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    if request.content_type == 'application/json'
      create_note_from_json_params
    else
      @note = Note.create(content: params[:content])
    end
    redirect_to long_post_path(@note.params), status: :created if @note.publish!
  end

  private
    def create_note_from_json_params
      @note = Note.create(content: params[:properties][:content])
    end
end
