FactoryGirl.define do
  factory :restaurant do
    name { FFaker::Product.product_name }
user_id 1
address { FFaker::Product.product_name }
city { FFaker::Product.product_name }
postal { FFaker::Product.product_name }
province { FFaker::Product.product_name }
country { FFaker::Product.product_name }
menu_id 1
  end
end
