class FermentableManifest < ActiveRecord::Base
  attr_accessible :amount, :fermentable_id, :notes, :recipe_id
  validates :fermentable_id, :recipe_id, :amount, presence: true
  belongs_to :recipe
  belongs_to :fermentable
#  accepts_nested_attributes_for :fermentable
end
