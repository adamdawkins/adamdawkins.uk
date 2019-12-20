class AdamController < ApplicationController
  layout 'adam'
  before_action :authenticate_adam!

  def authenticate_adam!
    return if logged_in?

    session[:pre_auth_path] = request.path
    redirect_to login_path
  end
end
