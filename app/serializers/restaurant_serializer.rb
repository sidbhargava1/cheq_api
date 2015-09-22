class RestaurantSerializer < ActiveModel::Serializer
  attributes :id, :name, :address, :city, :postal, :province, :country, :menu_id
    has_one :user
end
