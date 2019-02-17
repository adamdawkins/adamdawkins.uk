require "rails_helper"

RSpec.describe "Webmention receiver", type: :request do
  describe "verifying the request" do
    it "must reject the request if the source URL is malformed" do
      post "http://localhost:3000/webmentions", { params: { source: "mailto:adam@dragondrop.uk", target: "http://adam.example" } }
      expect(response).to_not be_successful
    end

    it "must reject the request if the target URL is malformed" do
      post "http://localhost:3000/webmentions", { params: { source: "http://source.com", target: "http://adam" } }
      expect(response).to_not be_successful
    end

    it "must reject the request when source and target URLs are the same" do
      post "http://localhost:3000/webmentions", { params: { source: "http://adam.example", target: "http://adam.example" } }
      expect(response).to_not be_successful
    end

    it "must reject the request if the source URL is not found" do
      source = "http://sourceexample.com/posts/1"
      stub_request(:get, source).and_return(status: 404)
      post "http://localhost:3000/webmentions", { params: { source: source, target: "http://adam.example/1" } }

      expect(response).to_not be_successful
    end

     it "must reject the request if the source document does not contain a valid match of the target URL" do
     end
  end
end
