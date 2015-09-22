class Api::V1::RestaurantsController < ApplicationController
    before_action :authenticate_with_token!, only: [:create, :update]
    respond_to :json
    
    def index
        restaurants = params[:restaurant_ids].present? ? Restaurant.find(params[:restaurant_ids]) : Restaurant.all
        respond_with restaurants
    end
    
    def show
        respond_with Restaurant.find(params[:id])
    end
    
    def update
        restaurant = current_user.restaurants.find(params[:id])
        if restaurant.update(restaurant_params)
            render json: restaurant, status: 200, location: [:api, restaurant]
        else
            render json: { errors: restaurant.errors }, status: 422
        end
    end
    
    def create
        restaurant = current_user.restaurants.build(restaurant_params)
        if restaurant.save
            render json: restaurant, status: 201, location: [:api, restaurant]
        else
            render json: { errors: restaurant.errors }, status: 422
        end
    end
    
    def destroy
        restaurant = current_user.restaurants.find(params[:id])
        restaurant.destroy
        head 204
    end
    
    def restaurant_params
        params.require(:restaurant).permit(:name, :address, :city, :postal, :province, :country, :menu_id)
    end
end