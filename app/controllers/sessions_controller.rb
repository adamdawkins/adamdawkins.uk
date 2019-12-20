class SessionsController < ApplicationController
  def new; end

  def create
    login
    if logged_in?
      redirect_to session[:pre_auth_path] || root_url
    else
      render :new, notice: 'Wrong!'
    end
  end

  private

  def login
    return unless params[:password] ==
                  Rails.application.credentials.adam[:password]

    session[:logged_in] = Rails.application.credentials.adam[:username]
  end
end
