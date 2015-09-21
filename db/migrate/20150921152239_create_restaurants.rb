class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.string :name, default: ""
      t.integer :user_id
      t.string :address, default: ""
      t.string :city, default: ""
      t.string :postal, default: ""
      t.string :province, default: ""
      t.string :country, default: ""
      t.integer :menu_id

      t.timestamps
    end
    add_index :restaurants, :user_id
  end
end
