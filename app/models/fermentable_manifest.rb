class FermentableManifest < ActiveRecord::Base
  attr_accessible :amount, :fermentable_id, :notes, :recipe_id
end
