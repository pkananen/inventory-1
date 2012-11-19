class CreateLevels < ActiveRecord::Migration
  def change
    create_table :levels do |t|
      t.string :name
      t.text :description
      t.string :image_url
      t.references :container

      t.timestamps
    end
    add_index :levels, :container_id
  end
end
