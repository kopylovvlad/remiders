class CreateItemLists < ActiveRecord::Migration
  def change
    create_table :item_lists do |t|
      t.string :name
      t.string :color
      t.boolean :public, default: :false
      t.timestamps null: false
    end
  end
end
