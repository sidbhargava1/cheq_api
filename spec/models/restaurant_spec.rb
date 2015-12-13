require 'spec_helper'

RSpec.describe Restaurant, type: :model do
  before { @restaurant = FactoryGirl.build :restaurant }
  subject { @restaurant }
    
  #let(:restaurant) { FactoryGirl.build :restaurant }
  #subject { restaurant }
    
  it { should respond_to(:name) }
  it { should respond_to(:address) }
  it { should respond_to(:city) }
  it { should respond_to(:postal) }
  it { should respond_to(:province) }
  it { should respond_to(:country) }
  it { should respond_to(:user_id) }
    
  it { should validate_presence_of :name }
  it { should validate_presence_of :address }    
  it { should validate_presence_of(:city) }
  it { should validate_presence_of(:postal) }
  it { should validate_presence_of(:province) }
  it { should validate_presence_of(:country) }
  it { should validate_presence_of(:user_id) }

  it { should have_many(:menus) }
  it { should belong_to :user }

  describe "#menus association" do
    before do
        @restaurant.save
        3.times { FactoryGirl.create :menu, restaurant: @restaurant }
    end
    
    it "destroys the associated menus on self destruct" do
        menus = @restaurant.menus
        @restaurant.destroy
        menus.each do |menu|
            expect(Menu.find(menu)).to raise_error ActiveRecord::RecordNotFount
        end
    end
  end
end