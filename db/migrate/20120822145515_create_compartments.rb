class CreateCompartments < ActiveRecord::Migration
  def change
    create_table :compartments do |t|
      t.string :name
      t.text :description
      t.references :level

      t.timestamps
    end
    add_index :compartments, :level_id
  end
end
