class RemoveFieldNameFromTableName < ActiveRecord::Migration
  def change
    remove_column :restaurants, :menu_id, :integer
  end
end
