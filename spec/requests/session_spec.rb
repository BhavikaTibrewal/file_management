require 'rails_helper'

RSpec.describe "Session", type: :request do
  let(:user1) {create :user}
  describe "GET /signup" do
    before do
      get '/signup'
    end
    it { expect(response).to have_http_status(200) }
    it { expect(response.content_type.to_s).to eq "text/html; charset=utf-8" }
  end

  describe "Sign in" do
    before do
      get '/login'
    end
    it { expect(response).to have_http_status(200) }
    it { expect(response.content_type.to_s).to eq "text/html; charset=utf-8" }
  end

  describe "GET destroy" do
    before do

      delete '/logout'
    end
    it { expect(response).to have_http_status(302) }
    it { expect(response.content_type.to_s).to eq "text/html; charset=utf-8"  }
    it { is_expected.to redirect_to '/login' }
    it { expect(session[:user_id]).to be_nil }
  end

  describe "#new" do
    it 'should render user' do
      get '/'
      expect(response).to render_template(:new)
    end
  end

  describe "#login" do
    it 'should login' do
      post '/login', params: {
        username: user1.username,
        password: "Password@123"
      }
      expect(response).to redirect_to root_path
    end

  end
end
