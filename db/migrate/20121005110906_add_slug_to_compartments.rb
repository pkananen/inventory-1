class AddSlugToCompartments < ActiveRecord::Migration
  def change
    add_column :compartments, :slug, :string
  end
end
