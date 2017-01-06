class AddUserIdToItemList < ActiveRecord::Migration
  def change
    add_column :item_lists, :user_id, :integer
  end
end
