class AddDescriptionToItemList < ActiveRecord::Migration
  def change
    add_column :item_lists, :description, :text
  end
end
