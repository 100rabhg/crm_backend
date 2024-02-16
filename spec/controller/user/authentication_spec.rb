require 'rails_helper'
require 'byebug'

RSpec.describe "Authentication", type: :request do
    let(:user) { create(:user, email: "test@example.com", password: "password") }
  
    describe "POST /signup" do
      it "creates a new user" do
        post "/signup", params: { user: { email: "new_user@example.com", password: "password" } }
        expect(response).to have_http_status(:ok)
        expect(User.count).to eq(1)
      end
    end
  
    describe "POST /login" do
      it "logs in an existing user" do
        post "/login", params: { user: {email: user.email, password: user.password}}
        expect(response).to have_http_status(:ok)
        expect(response.body).to include("Logged in successfully")
      end
    end
  end
  