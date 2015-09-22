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
    
    describe "POST #create" do
        context "when is successfully created" do
            before (:each) do
                user = FactoryGirl.create :user
                @restaurant_attributes = FactoryGirl.attributes_for :restaurant
                api_authorization_header user.auth_token
                post :create, { user_id: user.id, restaurant: @restaurant_attributes }
            end
            
            it "renders the json representation for the restaurant record just created" do
                restaurant_response = json_response
                expect(restaurant_response[:name]).to eql @restaurant_attributes[:name]
            end
            
            it { should respond_with 201 }
        end
        
        context "when is not created" do
            before(:each) do
                user = FactoryGirl.create :user
                @invalid_restaurant_attributes = { name: "Invalid name", address: "Invalid address", city: "Invalid city", postal: "Invalid postal", province: "Invalid province", country: "Invalid country", menu_id: nil}
                api_authorization_header user.auth_token
                post :create, { user_id: user.id, restaurant: @invalid_restaurant_attributes }
            end
            
            it "renders an errors json" do
                restaurant_response = json_response
                expect(restaurant_response).to have_key(:errors)
            end
            
            it "renders the json errors on why the user could not be created" do
                restaurant_response = json_response
                expect(restaurant_response[:errors][:menu_id]).to include "can't be blank"
            end
            
            it { should respond_with 422 }
        end
    end
    
    describe "PUT/PATCH #update" do
        before(:each) do
            @user = FactoryGirl.create :user
            @restaurant = FactoryGirl.create :restaurant, user: @user
            api_authorization_header @user.auth_token
        end
        
        context "when is successfully updated" do
            before(:each) do
                patch :update, { user_id: @user.id, id: @restaurant.id, restaurant: { name: "this is an updated name" } }
            end
            
            it "renders the json representation for the updated user" do 
                restaurant_response = json_response
                expect(restaurant_response[:name]).to eql "this is an updated name"
            end
            
            it { should respond_with 200 }
        end
        
        context "when is not updated" do
            before(:each) do
                patch :update, { user_id: @user.id, id: @restaurant.id, restaurant: { menu_id: nil } }
            end
            
            it "renders an errors json" do
                restaurant_response = json_response
                expect(restaurant_response).to have_key(:errors)
            end
            
            it "renders the json errors on why the user could not be created" do
                restaurant_response = json_response
                expect(restaurant_response[:errors][:menu_id]).to include "can't be blank"
            end
            
            it { should respond_with 422 }
        end
    end
    
    describe "DELETE #destroy" do
        before(:each) do
            @user = FactoryGirl.create :user
            @restaurant = FactoryGirl.create :restaurant, user: @user
            api_authorization_header @user.auth_token
            delete :destroy, { user_id: @user.id, id: @restaurant.id }
        end
        
        it { should respond_with 204 }
    end
end