class CreateFermentableManifests < ActiveRecord::Migration
  def change
    create_table :fermentable_manifests do |t|
      t.integer :recipe_id
      t.integer :fermentable_id
      t.float :amount
      t.string :notes

      t.timestamps
    end
  end
end
