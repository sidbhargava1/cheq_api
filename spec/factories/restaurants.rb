FactoryGirl.define do
  factory :restaurant do
    name { FFaker::Company.name }
user
address { FFaker::AddressUS.street_address }
city { FFaker::AddressUS.city }
postal { FFaker::AddressUS.zip_code }
province { FFaker::AddressUS.state }
country { FFaker::AddressUS.country }
  end
end
