class Restaurant < ActiveRecord::Base
    validates :name, :address, :city, :postal, :province, :country, :user_id, :menu_id, presence: true
    
    belongs_to :user
end