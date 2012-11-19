class AddCategoryIdToItems < ActiveRecord::Migration
  def change
    alter_table :items do |t|
      t.belongs_to :category
    end
    add_index :items, :category_id
  end
end
