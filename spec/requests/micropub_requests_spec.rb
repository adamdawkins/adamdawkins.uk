require 'spec_helper'
require 'rails_helper'

def stub_indieauth_with(token, res)
  stub_request(:get, 'https://tokens.indieauth.com/token')
    .with(headers: { 'Authorization': "Bearer #{token}" })
    .to_return(body: res, status: 200)
end

RSpec.describe 'Micropub Requests', type: :request do
  let(:good_token) { 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJtZSI6Imh0dHBzOlwvXC9hZGFtZGF3a2lucy5uZ3Jvay5pb1wvIiwiaXNzdWVkX2J5IjoiaHR0cHM6XC9cL3Rva2Vucy5pbmRpZWF1dGguY29tXC90b2tlbiIsImNsaWVudF9pZCI6Imh0dHBzOlwvXC9taWNyb3B1Yi5yb2Nrc1wvIiwiaXNzdWVkX2F0IjoxNTY4MzI5OTA5LCJzY29wZSI6ImNyZWF0ZSB1cGRhdGUgZGVsZXRlIHVuZGVsZXRlIiwibm9uY2UiOjI5NTYzMTAwMH0.lwD04viW1t_jV3AQ5k-IoOSe8iS8jlFkRWfU4qw-B3U' }

  let(:indieauth_response) { CGI.escape "me=https://#{ENV['FULL_URL']}&issued_by=https://tokens.indieauth.com" }

  before :all do
    VCR.turn_off!
  end

  after :all do
    VCR.turn_on!
  end

  describe 'POST /micropub' do
    it '100: Creates a basic form-encoded h-entry post' do
      stub_indieauth_with(good_token, indieauth_response)
      headers = { "Authorization": "Bearer #{good_token}" }
      post micropub_url, params: { h: 'entry', content: 'Hello world' }, headers: headers

      expect(response).to have_http_status :created
      expect(response.headers['Location']).to match(/hello-world/)
    end

    it '200: Create an h-entry post (JSON)' do
      stub_indieauth_with(good_token, indieauth_response)
      headers = { 'CONTENT_TYPE' => 'application/json', 'Authorization' => "Bearer #{good_token}" }
      post micropub_url, params: '{ "type": ["h-entry"], "properties": { "content": ["Micropub test of creating an h-entry with a JSON request"] } }', headers: headers

      expect(response).to have_http_status :created
      expect(response.headers['Location']).to match(/micropub-test/)
    end
  end

  context '-> Authorization ->' do
    it '803: Rejects unauthenticated requests' do
      post micropub_url, params: { h: 'entry', content: 'Testing+unauthenticated+request.+This+should+not+create+a+post.' }, headers: {}

      expect(response).to have_http_status :unauthorized

      expect(Post.last).to be_nil
    end

    it '800: Accepts access token in HTTP header' do
      stub_indieauth_with(good_token, indieauth_response)
      post micropub_url, params: { h: 'entry', content: 'Testing+accepting+access+token+in+HTTP+Authorization+header' }, headers: { 'Authorization': "Bearer #{good_token}" }

      expect(response).to have_http_status :created
      expect(response.headers['Location']).to match(/testing-accepting/)
    end

    it 'rejects a request with a token for antoher website' do
      bad_response = CGI.escape 'me=https://johnnorris.com&issued_by=https://tokens.indieauth.com'
      stub_indieauth_with('made_up_token', bad_response)
      post micropub_url, params: { h: 'entry', content: 'Testing+accepting+access+token+in+HTTP+Authorization+header' }, headers: { 'Authorization': 'Bearer made_up_token' }

      expect(response).to have_http_status :unauthorized
    end
  end
end
