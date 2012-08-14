class CreateFermentables < ActiveRecord::Migration
  def change
    create_table :fermentables do |t|
      t.string :name
      t.integer :ppg
      t.float :unit_price
      t.string :weight_unit

      t.timestamps
    end
  end
end
