require 'rails_helper'

RSpec.describe "Articles Requests", type: :request do
  describe "get /articles" do
    before do
      create(:article)
      get '/articles'
    end

    it "returns successfully" do
      expect(response).to be_successful
    end

    it "has an Articles heading" do
      expect(response.body).to include "Articles"
    end

    it "shows published articles" do
      expect(response.body).to include "h-entry"
    end
  end

  describe "get /articles/:year/:month/:day/:sequence/:slug" do
    context "the article exists" do
      it "displays the article the article?"
    end

    context "the article doesn't exist" do
      it "responds with a 404"
      it "suggests /articles and the root_path"
    end
  end
end
