require "rails_helper"

RSpec.describe "Notes Requests", type: :request do
  describe "The homepage" do
    it "renders a Notes heading" do
      get "/"
      expect(response).to be_successful
      expect(response.body).to include("Notes")
    end
    it "shows the bio" do
      get "/"
      expect(response.body).to include("h-card")
    end
     it "shows published notes" do
      FactoryBot.create(:note, content: "Contents", published_at: Time.now)
      get "/"

      expect(response.body).to include("Contents")
     end
  end
end
