class RemoveNameToTitle < ActiveRecord::Migration
  def change
    rename_column :items, :name, :title
    rename_column :item_lists, :name, :title
  end
end
