class AddDescriptionToHops < ActiveRecord::Migration
  def change
    add_column :hops, :description, :string
  end
end
