require 'spec_helper'

RSpec.describe Api::V1::MenusController, type: :controller do
    describe "GET #show" do
        before (:each) do
            @menu = FactoryGirl.create :menu
            get :show, id: @menu.id
        end
        
        it "returns the information about a menu on a hash" do
            menu_response = json_response[:menu]
            expect(menu_response[:desc]).to eql @menu.desc
        end
        
        it { should respond_with 200 }
    end
    
   #  describe "POST #create" do
   #     context "when is successfully created" do
   #         before(:each) do
   #             user = FactoryGirl.create :user
   #             restaurant = FactoryGirl.create :restaurant, user: @user
   #             @menu_attributes = FactoryGirl.attributes_for :menu
               
   #             api_authorization_header user.auth_token
   #             post :create, { restaurant_id: restaurant.id, menu: @menu_attributes }
   #         end
            
   #         it "renders the json representation for the menu record just created" do
   #             menu_response = json_response
   #             expect(menu_response[:desc]).to eql @menu_attributes[:desc]
   #         end
            
   #         it { should respond_with 201 }
   #     end 
   # end
end