class RemoveAauFromHops < ActiveRecord::Migration
  def up
    remove_column :hops, :aau
      end

  def down
    add_column :hops, :aau, :float
  end
end
