require 'rails_helper'

RSpec.describe Api::CustomersController, type: :controller do
  let(:user) { create(:user) }
  let(:customer) { create(:customer) }

  describe "GET #index" do
    it "returns a list of customers" do
      sign_in user
      customer
      get :index
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).not_to be_empty
    end
  end

  describe "GET #show" do
    context "when user is authenticated" do
      it "returns the specified customer" do
        sign_in user
        get :show, params: { id: customer.id }
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)["id"]).to eq(customer.id)
      end
    end

    context "when user is not authenticated" do
      it "does not return customer" do
        get :show, params: { id: customer.id }
        expect(response).to have_http_status(:unauthorized)
        expect(response.body).to eq("You need to sign in or sign up before continuing.")
      end
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "creates a new customer" do
        sign_in user
        post :create, params: { customer: attributes_for(:customer) }
        expect(response).to have_http_status(:created)
      end
    end

    context "with invalid attributes" do
      it "does not create a new customer" do
        sign_in user
        post :create, params: { customer: attributes_for(:customer, name: nil) }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PATCH #update" do
    let(:customer) { create(:customer) }

    context "with valid attributes" do
      it "updates the customer" do
        sign_in user
        patch :update, params: { id: customer.id, customer: { name: "New Name" } }
        expect(response).to have_http_status(:ok)
      end
    end

    context "with invalid attributes" do
      it "does not update the customer" do
        sign_in user
        patch :update, params: { id: customer.id, customer: { name: nil } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE #destroy" do
    let(:customer) { create(:customer) }

    it "deletes the customer" do
      sign_in user
      delete :destroy, params: { id: customer.id }
      expect(response).to have_http_status(:no_content)
    end
  end
end

