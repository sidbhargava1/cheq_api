require 'spec_helper'

RSpec.describe Menu, type: :model do
    before { @menu = FactoryGirl.build :menu }
    subject { @menu }
    
    it { should respond_to(:desc) }
    it { should respond_to(:menu_item_id) }
    it { should respond_to(:restaurant_id) }
    
    it { should validate_presence_of :desc }
    it { should validate_presence_of(:menu_item_id) }
    it { should validate_presence_of(:restaurant_id) }
    
    it { should have_many(:menuItems) }
    it { should belong_to :restaurant }
    
    describe "#menuItems association" do
    before do
        @menu.save
        3.times { FactoryGirl.create :menuItem, menu: @menu }
    end
    
    it "destroys the associated menus on self destruct" do
        menuItems = @menu.menuItems
        @menu.destroy
        menuItems.each do |menuItem|
            expect(MenuItem.find(menuItem)).to raise_error ActiveRecord::RecordNotFount
        end
    end
  end
end
