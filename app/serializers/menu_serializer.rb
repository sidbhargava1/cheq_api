class MenuSerializer < ActiveModel::Serializer
  attributes :id, :desc
  has_many :menuItems
end
