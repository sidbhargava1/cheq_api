class Restaurant < ActiveRecord::Base
    validates :name, :address, :city, :postal, :province, :country, :user_id, presence: true
    belongs_to :user
    has_many :menus, dependent: :destroy
end