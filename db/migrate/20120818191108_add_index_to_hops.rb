class AddIndexToHops < ActiveRecord::Migration
  def change
    add_index :hops, :name, unique: true
  end
end
