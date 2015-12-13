class MenuItemSerializer < ActiveModel::Serializer
  attributes :id, :title, :desc, :price, :spice, :veg, :healthy
end
