require 'spec_helper'
require 'rails_helper'

RSpec.describe "Micropub Requests", type: :request do
  describe "POST /micropub" do
    it "100: Creates a basic form-encoded h-entry post" do
      post micropub_url, params: { h: 'entry', content: 'Hello world' }

      expect(response).to have_http_status :created
      expect(response.headers["Location"]).to match /hello-world/
    end

    it "200: Create an h-entry post (JSON)" do
      headers = { "CONTENT_TYPE" => "application/json" }
      post micropub_url, params: '{ "type": ["h-entry"], "properties": { "content": ["Micropub test of creating an h-entry with a JSON request"] } }', headers: headers

      expect(response).to have_http_status :created
      expect(response.headers["Location"]).to match /micropub-test/
    end
  end
end
