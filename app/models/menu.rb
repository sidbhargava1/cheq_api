class Menu < ActiveRecord::Base
    validates :desc, :menu_item_id, :restaurant_id, presence: true
    belongs_to :restaurant
    has_many :menuItems, dependent: :destroy
end
