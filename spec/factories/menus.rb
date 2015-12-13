FactoryGirl.define do
  factory :menu do
      desc { FFaker::Company.name }
      menu_item_id 1
      restaurant
  end
end