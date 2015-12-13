require 'spec_helper'

RSpec.describe MenuItem, type: :model do
    let(:menuItem) { FactoryGirl.build :menuItem }
    subject { menuItem }
    
    it { should respond_to(:title) }
    it { should respond_to(:desc) }
    it { should respond_to(:price) }
    it { should respond_to(:spice) }
    it { should respond_to(:veg) }
    it { should respond_to(:healthy) }
    it { should respond_to(:menu_id) }
    
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:desc) }
    it { should validate_presence_of(:price) }
    it { should validate_presence_of(:spice) }
    it { should allow_value(nil).for(:veg) }
    it { should allow_value(nil).for(:healthy) }
    it { should validate_presence_of(:menu_id) }
    
    it { should belong_to :menu }
end
