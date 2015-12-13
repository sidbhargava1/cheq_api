require 'spec_helper'

RSpec.describe Api::V1::RestaurantsController, type: :controller do
    describe "GET #show" do
        before(:each) do
            @restaurant = FactoryGirl.create :restaurant
            get :show, id: @restaurant.id
        end
        
        it "returns the information about a reporter on a hash" do
            restaurant_response = json_response[:restaurant]
            expect(restaurant_response[:name]).to eql @restaurant.name
        end
        
        it { should respond_with 200 }
    end
    
    describe "GET #index" do
        before(:each) do
            @restaurants = []
            4.times { @restaurants.push FactoryGirl.create :restaurant }
        end
        
        context "when is not receiving any restaurant_ids parameter" do
            before(:each) do
                @restaurants.each do |rest|
                    FactoryGirl.create :menu, restaurant: rest
                end
                get :index
            end
        
            it "returns 4 records from the database" do
                restaurants_response = json_response
                expect(restaurants_response[:restaurants]).to have(4).items
            end

            it "returns the menu ids embeded into each restaurant" do
                restaurants_response = json_response[:restaurants]
                restaurants_response.each do |restaurant_response|
                    expect(restaurant_response[:menu_ids]).to be_present
                end
            end
        
            it { should respond_with 200 }
        end

        #TODO: Implement search for restaurants within the current user
        # context "when restaurant_ids parameter is sent" do
        #     before(:each) do
        #         @user = FactoryGirl.create :user
        #         3.times { FactoryGirl.create :restaurant, user: @user }
        #         get :index, restaurant_ids: @user.restaurant_ids
        #     end
            # restaurant object does not contain the user object anymore
        #     it "returns just the restaurants that belong to the user" do
        #         restaurants_response = json_response[:restaurants]
        #         restaurants_response.each do |restaurant_response|
        #             expect(restaurant_response[:user][:email]).to eql @user.email
        #         end
        #     end
        # end
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
                restaurant_response = json_response[:restaurant]
                expect(restaurant_response[:name]).to eql @restaurant_attributes[:name]
            end
            
            it { should respond_with 201 }
        end
        
        # context "when is not created" do
        #     before(:each) do
        #         user = FactoryGirl.create :user
        #         @invalid_restaurant_attributes = { name: "Invalid name", address: "Invalid address", city: "Invalid city", postal: "Invalid postal", province: "Invalid province", country: "Invalid country", menu_id: nil}
        #         api_authorization_header user.auth_token
        #         post :create, { user_id: user.id, restaurant: @invalid_restaurant_attributes }
        #     end
            
        #     it "renders an errors json" do
        #         restaurant_response = json_response
        #         expect(restaurant_response).to have_key(:errors)
        #     end
            
        #     it "renders the json errors on why the user could not be created" do
        #         restaurant_response = json_response
        #         expect(restaurant_response[:errors][:menu_id]).to include "can't be blank"
        #     end
            
        #     it { should respond_with 422 }
        # end
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
                restaurant_response = json_response[:restaurant]
                expect(restaurant_response[:name]).to eql "this is an updated name"
            end
            
            it { should respond_with 200 }
        end
        
        # context "when is not updated" do
        #     before(:each) do
        #         patch :update, { user_id: @user.id, id: @restaurant.id, restaurant: { menu_id: nil } }
        #     end
            
        #     it "renders an errors json" do
        #         restaurant_response = json_response
        #         expect(restaurant_response).to have_key(:errors)
        #     end
            
        #     it "renders the json errors on why the user could not be created" do
        #         restaurant_response = json_response
        #         expect(restaurant_response[:errors][:menu_id]).to include "can't be blank"
        #     end
            
        #     it { should respond_with 422 }
        # end
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