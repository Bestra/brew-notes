class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.string :name
      t.integer :style_id
      t.integer :user_id
      t.integer :ibu
      t.float :og
      t.float :fg

      t.timestamps
    end
  end
end
