class HopManifest < ActiveRecord::Base
  attr_accessible :amount, :boil_time, :hop_id, :notes, :recipe_id
end
