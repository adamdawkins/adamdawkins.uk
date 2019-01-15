module SessionsHelper
  def logged_in?
    session[:logged_in] === ENV['ADAM_USERNAME']
  end
end
