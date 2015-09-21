class Api::V1::RestaurantsController < ApplicationController
    respond_to :json
    
    def index
        respond_with Restaurant.all
    end
    
    def show
        respond_with Restaurant.find(params[:id])
    end
end
