class MenuItem < ActiveRecord::Base
    validates :title, :desc, :price, :spice, :menu_id, presence: true
    validates :veg, :inclusion => { :in => [true, false, nil] }
    validates :healthy, :inclusion => { :in => [true, false, nil] }
    belongs_to :menu
end
