class PagesController < ApplicationController
  def show
    if template_exists?("pages/#{params[:page]}")
      render template: "pages/#{params[:page]}"
    else
      render file: "public/404.html", status: :not_found
    end
  end
end
