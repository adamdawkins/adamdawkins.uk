require 'rails_helper'

RSpec.describe 'Token Endpoint', type: :request do
  # request parameters
  # grant_type=authorization_code
  # code - The authorization code received from the authorization endpoint in the redirect
  # client_id - The client's URL, which MUST match the client_id used in the authorization request.
  # redirect_uri - The client's redirect URL, which MUST match the initial authorization request.
  # me - The user's profile URL as originally used in the authorization request
  
  it "verifies that the authorization code is valid"
  it "verifies that token request and code match on client_id, me and redirect_uri"
  it "verifies than the authorization code request contains at least one scope"

  context "the authorization code cannot be found" do
    it "rejects the request"
  end

  context "the client_id does not match from the code to the token request" do
    it "rejects the request"
  end

  context "the request is valid" do
    it "returns a JSON Object with an OAuth 2.0 Bearer Token"
    it "returns a token_type of 'Bearer'"
    it "returns a scope"
    it "returns the me url"
  end
end

