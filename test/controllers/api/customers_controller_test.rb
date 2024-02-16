require "test_helper"

class Api::CustomersControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
end


require 'rails_helper'
RSpec.describe Api::CustomersController, type: :controller do
  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Customer' do
        expect {
          post :create, params: { customer: { name: 'Test Customer', email: 'test@example.com' } }
        }.to change(Customer, :count).by(1)
      end
    end

    context 'with invalid params' do
      it 'returns unprocessable entity status' do
        post :create, params: { customer: { name: nil, email: nil } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  # Add similar tests for show, update, and destroy actions
end
