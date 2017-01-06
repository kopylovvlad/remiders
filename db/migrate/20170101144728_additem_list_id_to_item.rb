class AdditemListIdToItem < ActiveRecord::Migration
  def change
    add_column :items, :item_list_id, :integer
  end
end
