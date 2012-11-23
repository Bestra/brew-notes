class HopManifest < ActiveRecord::Base
  attr_accessible :recipe_id, :hop_id, :amount, :boil_time, :notes, :aau, :aa_percent
  validates :recipe_id, :hop_id, :boil_time, :aau, presence: true
  belongs_to :recipe
  belongs_to :hop
  accepts_nested_attributes_for :hop

end
