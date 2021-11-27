module Api
  module V1
    class CitiesController < ApplicationController
      before_action :set_city, only: %i[show update destroy]

      # GET /cities
      def index
        per_page = params[:per_page] || 10
        @cities = City.all.paginate(page: params[:page], per_page: per_page)

        if @cities.length >= 1
          render json: {
            status: 'SUCCESS',
            message: 'Successfully loaded cities',
            data: @cities,
            per_page: per_page.to_i,
            total_data: @cities.count,
            current_page: params[:page].to_i || 0,
            total_pages: @cities.total_pages.to_i
          },
                 include: [
                   { state: { except: %i[created_at updated_at] } }
                 ]
        else
          per_page = 0
          total_page = 0
          render json: {
            status: 'SUCCESS',
            message: 'There are no cities registered on this page',
            data: [],
            per_page: per_page.to_i,
            total_data: @cities.count,
            current_page: params[:page].to_i || 0,
            total_pages: @cities.total_pages.to_i
          }
        end
      end

      # GET /cities/1
      def show
        render json: {
          status: 'SUCCESS',
          message: 'Successfully loaded citie',
          data: @city
        },
               include: [
                 { state: { except: %i[created_at updated_at] } }
               ]
      end

      # POST /cities
      def create
        @city = City.new(city_params)

        if @city.save
          render json: {
            status: 'SUCCESS',
            message: 'Saved Successfully',
            data: @city,
            location: api_v1_state_url(@city)
          },
                 include: [
                   { state: { except: %i[created_at updated_at] } }
                 ]
        else
          render json: @city.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /cities/1
      def update
        if @city.update(city_params)
          render json: @city
        else
          render json: @city.errors, status: :unprocessable_entity
        end
      end

      # DELETE /cities/1
      def destroy
        @city.destroy
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_city
        @city = City.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def city_params
        params.require(:city).permit(:name, :state_id)
      end
    end
  end
end
