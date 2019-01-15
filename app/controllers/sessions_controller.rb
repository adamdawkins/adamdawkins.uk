class SessionsController < ApplicationController
  def new
  end

  def create
      puts Rails.application.credentials.adam[:password]
      puts params[:password]

    if params[:password] === Rails.application.credentials.adam[:password]
      session[:logged_in] = Rails.application.credentials.adam[:username]
      redirect_path = session[:pre_auth_path] || root_url
      redirect_to redirect_path
    else
      render :new, notice: "Wrong!"
    end

  end
end
