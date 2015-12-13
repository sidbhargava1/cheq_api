class CreateMenuItems < ActiveRecord::Migration
  def change
    create_table :menu_items do |t|
      t.string :title, default: ""
      t.string :desc, default: ""
      t.decimal :price, default: 0.0
      t.integer :spice, default: 0
      t.boolean :veg, default: false
      t.boolean :healthy, default: false
      t.integer :menu_id

      t.timestamps null: false
    end
      add_index :menu_items, :menu_id
  end
end
