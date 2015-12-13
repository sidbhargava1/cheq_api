FactoryGirl.define do
  factory :menuItem do
    title { FFaker::Company.name }
	desc { FFaker::Company.name }
	price "9.99"
	spice "0"
	veg false
	healthy false
	menu
  end
end