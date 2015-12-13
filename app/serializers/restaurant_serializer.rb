class RestaurantSerializer < ActiveModel::Serializer
  embed :ids
  attributes :id, :name, :address, :city, :postal, :province, :country
  has_many :menus
end
