class AddDoneToItem < ActiveRecord::Migration
  def change
    add_column :items, :is_done, :boolean, default: false
  end
end
