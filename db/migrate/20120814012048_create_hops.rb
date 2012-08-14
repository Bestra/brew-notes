class CreateHops < ActiveRecord::Migration
  def change
    create_table :hops do |t|
      t.string :name
      t.float :aau
      t.float :unit_price
      t.string :weight_unit

      t.timestamps
    end
  end
end
