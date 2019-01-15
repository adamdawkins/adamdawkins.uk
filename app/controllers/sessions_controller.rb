class SessionsController < ApplicationController
  def new
  end

  def create
    if params[:password] === ENV['ADAM_PASSWORD']
      session[:logged_in] = ENV['ADAM_USERNAME']
      redirect_path = session[:pre_auth_path] || root_url
      redirect_to redirect_path
    else
      flash[:notice] = 'Wrong!'
    end

  end
end
