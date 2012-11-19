class AddQuantityToItems < ActiveRecord::Migration
  def change
    #add_column :items, :quantity, :integer
    change_column :items, :value, :decimal, :precision => 8, :scale => 2, :default => 0.00
  end
end
