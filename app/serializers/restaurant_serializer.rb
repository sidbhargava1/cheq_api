class RestaurantSerializer < ActiveModel::Serializer
  attributes :id, :name, :address, :city, :postal, :province, :country, :menu_id
end
