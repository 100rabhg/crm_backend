class Api::InteractionsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_interaction, only: [:show, :update, :destroy]

    def index
      @interactions = Interaction.all
      render json: @interactions
    end

    def show
      render json: @interaction
    end

    def create
      @interaction = Interaction.new(interaction_params)
  
      if @interaction.save
        render json: @interaction, status: :created
      else
        render json: @interaction.errors, status: :unprocessable_entity
      end
    end

    def update
      if @interaction.update(interaction_params)
        render json: @interaction
      else
        render json: @interaction.errors, status: :unprocessable_entity
      end
    end

    def destroy
      @interaction.destroy
    end
  
    private
      def set_interaction
        @interaction = Interaction.find(params[:id])
      end

      def interaction_params
        params.require(:interaction).permit(:subject, :description, :contact_id)
      end
  end
  