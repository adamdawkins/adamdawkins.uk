class AdamController < ApplicationController
  def authenticate_adam!
    unless logged_in?
      session[:pre_auth_path] = request.path
      redirect_to login_path
    end
  end
end
