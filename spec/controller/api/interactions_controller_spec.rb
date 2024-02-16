require 'rails_helper'
require 'byebug'

RSpec.describe Api::InteractionsController, type: :controller do

    let(:user) { create(:user) }
    let(:contact) { create(:contact) }
    let(:interaction) { create(:interaction) }

    describe "GET #index" do
        it "returns a list of interactions" do
            sign_in user
            interaction
            get :index
            expect(response).to have_http_status(:ok)
            expect(JSON.parse(response.body)).not_to be_empty
        end
    end

    describe "GET #show" do
        context "when user is authenticated" do
            it "returns the specified interaction" do
                sign_in user
                get :show, params: { id: interaction.id }
                expect(response).to have_http_status(:ok)
                expect(JSON.parse(response.body)["id"]).to eq(interaction.id)
            end
        end

        context "when user is not authenticated" do
            it "does not return interaction" do
              get :show, params: { id: interaction.id }
              expect(response).to have_http_status(:unauthorized)
              expect(response.body).to eq("You need to sign in or sign up before continuing.")
            end
        end
    end
  
    describe "POST #create" do
      context "with valid attributes" do
        it "creates a new interaction" do
          sign_in user
          post :create, params: { interaction: attributes_for(:interaction, contact_id: contact.id) }
          expect(response).to have_http_status(:created)
        end
      end
  
      context "with invalid attributes" do
        it "does not create a new interaction" do
          sign_in user
          post :create, params: { interaction: attributes_for(:interaction, subject: nil, contact_id: contact.id) }
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end
  
    describe "PATCH #update" do
      let(:interaction) { create(:interaction, contact: contact) }
  
      context "with valid attributes" do
        it "updates the interaction" do
          sign_in user
          patch :update, params: { id: interaction.id, interaction: { subject: "New Subject" } }
          expect(response).to have_http_status(:ok)
        end
      end
  
      context "with invalid attributes" do
        it "does not update the interaction" do
          sign_in user
          patch :update, params: { id: interaction.id, interaction: { subject: nil } }
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end
  
    describe "DELETE #destroy" do
      let(:interaction) { create(:interaction, contact: contact) }
  
      it "deletes the interaction" do
        sign_in user
        delete :destroy, params: { id: interaction.id }
        expect(response).to have_http_status(:no_content)
      end
    end
  end
  