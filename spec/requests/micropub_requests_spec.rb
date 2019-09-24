require 'spec_helper'
require 'rails_helper'

RSpec.describe "Micropub Requests", type: :request do
  describe "POST /micropub" do
    it "Creates a basic form-encoded h-entry post" do
      pp micropub_url
    post micropub_url, params: { h: 'entry', content: 'Hello world' }
    pp response.headers
    expect(response).to have_http_status :created
    expect(response.headers["Location"]).to match /Hello-world/
    end

  end
end
