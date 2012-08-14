class CreateHopManifests < ActiveRecord::Migration
  def change
    create_table :hop_manifests do |t|
      t.integer :recipe_id
      t.integer :hop_id
      t.float :amount
      t.integer :boil_time
      t.string :notes

      t.timestamps
    end
  end
end
