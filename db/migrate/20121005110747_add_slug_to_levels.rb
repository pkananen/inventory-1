class AddSlugToLevels < ActiveRecord::Migration
  def change
    add_column :levels, :slug, :string
  end
end
