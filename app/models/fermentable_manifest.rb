class FermentableManifest < ActiveRecord::Base
  belongs_to :recipe
  attr_accessible :amount, :fermentable_id, :notes, :recipe_id
end
