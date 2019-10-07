require 'rails_helper'
require 'spec_helper'
require 'support/auth_helpers'

RSpec.describe "Adam / Repost Requests", type: :request do
  describe "GET /adam/reposts/new" do
    context "logged in as Adam" do
      before do
        login_as_adam
      end
      it 'renders successfully' do
        get new_adam_repost_url
        expect(response).to have_http_status 200
      end
    end
  end

  describe "GET /adam/reposts/:id" do
    let(:repost) { create(:repost) }
    context "logged in as Adam" do
      before do
        login_as_adam
      end
      it 'renders successfully' do
        pp repost
        get adam_repost_url(id: repost.id)
        expect(response).to have_http_status 200
      end
    end
  end

  describe "POST /adam/reposts/new" do
    let(:valid_repost_params) { attributes_for(:repost) }
    context "logged in as Adam" do
      before do
        login_as_adam
      end
      context "~> with valid repost parameters ~>" do
        it 'redirects to the repost' do
          post adam_reposts_url, params: { repost: valid_repost_params }
          expect(response).to redirect_to adam_repost_url(id: Repost.last.id)
        end
      end
      context "~> with invalid repost parameters ~>" do
        it 'renders the new template' do
          post adam_reposts_url, params: { repost: {content: 'text', repost_of: nil }}
          expect(response).to render_template 'adam/reposts/new'
        end
      end
    end
  end
end
