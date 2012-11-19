class AddQuantidtyToItems < ActiveRecord::Migration
  def change
    change_column :items, :value, :decimal, :precision => 10, :scale => 2, :default => 0.00
  end
end
