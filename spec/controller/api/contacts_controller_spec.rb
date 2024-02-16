require 'rails_helper'

RSpec.describe Api::ContactsController, type: :controller do
  let(:user) { create(:user) }
  let(:customer) { create(:customer) }
  let(:contact) { create(:contact) }

  describe "GET #index" do
    it "returns a list of contacts" do
      sign_in user
      contact
      get :index
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).not_to be_empty
    end
  end

  describe "GET #show" do
    context "when user is authenticated" do
      it "returns the specified contact" do
        sign_in user
        get :show, params: { id: contact.id }
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)["id"]).to eq(contact.id)
      end
    end
    
    context "when user is not authenticated" do
      it "does not return contact" do
        get :show, params: { id: contact.id }
        expect(response).to have_http_status(:unauthorized)
        expect(response.body).to eq("You need to sign in or sign up before continuing.")
      end
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "creates a new contact" do
        sign_in user
        post :create, params: { contact: attributes_for(:contact, customer_id: customer.id) }
        expect(response).to have_http_status(:created)
      end
    end

    context "with invalid attributes" do
      it "does not create a new contact" do
        sign_in user
        post :create, params: { contact: attributes_for(:contact, address: nil, customer_id: customer.id) }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PATCH #update" do
    let(:contact) { create(:contact) }

    context "with valid attributes" do
      it "updates the contact" do
        sign_in user
        patch :update, params: { id: contact.id, contact: { address: "New Address" } }
        expect(response).to have_http_status(:ok)
      end
    end

    context "with invalid attributes" do
      it "does not update the contact" do
        sign_in user
        patch :update, params: { id: contact.id, contact: { address: nil } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE #destroy" do
    let(:contact) { create(:contact) }

    it "deletes the contact" do
      sign_in user
      delete :destroy, params: { id: contact.id }
      expect(response).to have_http_status(:no_content)
    end
  end
end
