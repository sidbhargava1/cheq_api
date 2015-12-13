class CreateMenus < ActiveRecord::Migration
  def change
    create_table :menus do |t|
      t.string :desc, default: ""
      t.integer :menu_item_id
      t.integer :restaurant_id
        
      t.timestamps null: false
    end
    add_index :menus, :restaurant_id
  end
end
