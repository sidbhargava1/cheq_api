require 'spec_helper'

describe User do
  before { @user = FactoryGirl.build(:user) }

  subject { @user }

  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
 
  # we test the user actually respond to this attribute
  it { should respond_to(:auth_token) }
  
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }
  it { should validate_confirmation_of(:password) }
  it { should allow_value('example@domain.com').for(:email) }

  it {should have_many(:restaurants) }
    
  # we test the auth_token is unique
  it { should validate_uniqueness_of(:auth_token)}
  
  describe "#generate_authentication_token!" do
    it "generates a unique token" do
      Devise.stub(:friendly_token).and_return("auniquetoken123")
      @user.generate_authentication_token!
      expect(@user.auth_token).to eql "auniquetoken123"
    end

    it "generates another token when one already has been taken" do
      existing_user = FactoryGirl.create(:user, auth_token: "auniquetoken123")
      @user.generate_authentication_token!
      expect(@user.auth_token).not_to eql existing_user.auth_token
    end
  end

  describe "#restaurants association" do
    before do
        @user.save
        3.times { FactoryGirl.create :restaurant, user: @user }
    end
    
    it "destroys the associated restaurants on self destruct" do
        restaurants = @user.restaurants
        @user.destroy
        restaurants.each do |restaurant|
            expect(Restaurant.find(restaurant)).to raise_error ActiveRecord::RecordNotFount
        end
    end
  end

  describe "#menu association" do
    before do
        @user.save
        FactoryGirl.create :restaurant, user: @user
        3.times { FactoryGirl.create :menu, restaurant: @user.restaurants.first }
    end
    
    it "destroys the associated menus on self destruct" do
        menus = @user.restaurants.first.menus
        @user.destroy
        menus.each do |menu|
            expect(Menu.find(menu)).to raise_error ActiveRecord::RecordNotFount
        end
    end
  end

  describe "#menuItem association" do
    before do
        @user.save
        FactoryGirl.create :restaurant, user: @user
        FactoryGirl.create :menu, restaurant: @user.restaurants.first
        3.times { FactoryGirl.create :menuItem, menu: @user.restaurants.first.menus.first }
    end
    
    it "destroys the associated menu items on self destruct" do
        menuItems = @user.restaurants.first.menus.first.menuItems
        @user.destroy
        menuItems.each do |menuItem|
            expect(MenuItem.find(menuItem)).to raise_error ActiveRecord::RecordNotFount
        end
    end
  end
  it { should be_valid }
end