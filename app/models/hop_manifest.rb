class HopManifest < ActiveRecord::Base
  attr_accessible :recipe_id, :hop_id, :amount, :boil_time, :notes, :aau, :aa_percent
  belongs_to :recipe
  

end
