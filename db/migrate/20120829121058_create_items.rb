class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.text :description
      t.references :itemable, :polymorphic => true
      t.integer :value
      t.string :image

      t.timestamps
    end
  end
end
