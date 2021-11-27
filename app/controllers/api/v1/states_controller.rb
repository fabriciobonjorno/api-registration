module Api
  module V1
    class StatesController < ApplicationController
      before_action :set_state, only: %i[show update destroy]

      # GET /states
      def index
        per_page = params[:per_page] || 10
        @states = State.all.paginate(page: params[:page], per_page: per_page)

        if @states.length >= 0
          render json: {
            status: 'SUCCESS',
            message: 'Successfully loaded states',
            states: @states,
            per_page: per_page.to_i,
            total_data: @states.count,
            current_page: params[:page].to_i || 0,
            total_pages: @states.total_pages.to_i
          }
        else
          per_page = 0
          total_page = 0
          render json: {
            status: 'SUCCESS',
            message: 'There are no states registered on this page',
            states: [],
            per_page: per_page.to_i,
            total_data: @states.count,
            current_page: params[:page].to_i || 0,
            total_pages: @states.total_pages.to_i
          }
        end
      end

      # GET /states/1
      def show
        render json: @state
      end

      # POST /states
      def create
        @state = State.new(state_params)

        if @state.save
          render json: {
            status: 'SUCCESS',
            message: 'Saved Successfully',
            data: @state,
            location: api_v1_state_url(@state)
          }
        else
          render json: @state.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /states/1
      def update
        if @state.update(state_params)
          render json: @state
        else
          render json: @state.errors, status: :unprocessable_entity
        end
      end

      # DELETE /states/1
      def destroy
        @state.destroy
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_state
        @state = State.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def state_params
        params.require(:state).permit(:name, :initials)
      end
    end
  end
end
