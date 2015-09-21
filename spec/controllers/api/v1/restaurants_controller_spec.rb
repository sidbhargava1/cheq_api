require 'spec_helper'

RSpec.describe Api::V1::RestaurantsController, type: :controller do
    describe "GET #show" do
        before(:each) do
            @restaurant = FactoryGirl.create :restaurant
            get :show, id: @restaurant.id
        end
        
        it "returns the information about a reporter on a hash" do
            restaurant_response = json_response
            expect(restaurant_response[:name]).to eql @restaurant.name
        end
    
        it { should respond_with 200 }
    end
    
    describe "GET #index" do
        before(:each) do
            4.times { FactoryGirl.create :restaurant }
            get :index
        end
        
        it "returns 4 records from the database" do
            restaurants_response = json_response
            expect(restaurants_response[:restaurants]).to have(4).items
        end
            
        it { should respond_with 200 }
    end
end