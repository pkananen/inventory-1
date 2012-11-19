class AddSlugToContainers < ActiveRecord::Migration
  def change
    add_column :containers, :slug, :string
  end
end
