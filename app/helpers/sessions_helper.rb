module SessionsHelper
  def logged_in?
    session[:logged_in] == Rails.application.credentials.adam[:username]
  end
end
