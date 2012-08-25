class AddDescriptionToRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :description ,:string
    add_column :recipes, :final_volume , :float
  end
end
