class AddAauToHopManifest < ActiveRecord::Migration
  def change
    add_column :hop_manifests, :aau, :float
    add_column :hop_manifests, :aa_percent, :float
  end
end
