class WebmentionsController < ApplicationController
  before_action :set_params
  skip_before_action :verify_authenticity_token
  def create
    verified = Webmention::Verification.verified?(@source, @target)
    head :bad_request and return unless verified
    @mention = Mention.new(source:@source, target:@target)
    @mention.save
    head :ok
  end

  private
    def set_params
      @source = params[:source]
      @target = params[:target]
    end
end
