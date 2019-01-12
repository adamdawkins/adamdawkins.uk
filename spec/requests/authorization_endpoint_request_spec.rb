# rubocop:disable Metrics/LineLength
require 'rails_helper'

RSpec.describe 'AuthorizationEndpoint', type: :request do
  it "The authorization endpoint SHOULD fetch the client_id URL to retrieve application information and the client's registered redirect URLs, see Client Information Discovery for more information."

  context "URL scheme, host or port of redirect_uri MATCH client_id" do
    it "allows the request"
  end
  context "URL scheme, host or port of redirect_uri DO NOT match client_id" do
    context "redirect_uri DOES NOT match one of the redirect URLs published by the client" do
      it "blocks the request"
    end

    context "redirect_uri matches one of the redirect URLs published by the client" do
      it "allows the request"
    end
  end


  describe "Client Information discovery" do
    it "SHOULD [Fetch] the URL to find more information about the client."
  end

  context "user is not authenticated" do
    it "prompts authentication for the user"
  end

  context "user is authenticated" do
    it "presents the authorization prompt to the user"
    it "MUST indicate which application the user is signing in to"
    it "SHOULD provide as much detail as possible about the request, such as information about the requested scopes."
  end

  context "User approves request" do
    it "generates an authorization code and builds the redirect back to the client."
    it "The code MUST expire shortly after it is issued to mitigate the risk of leaks, (MAx 10 minutes)"
    it "sends a state parameter that MUST be set to the exact value that the client set in the request"
  end
end
