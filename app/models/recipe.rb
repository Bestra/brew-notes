class Recipe < ActiveRecord::Base
  attr_accessible :fg, :ibu, :name, :og, :style_id, :user_id
  has_many :hop_manifests, dependent: :destroy
  has_many :fermentable_manifests, dependent: :destroy
  has_many :hops, through: :hop_manifest
  has_many :fermentables, through: :fermentable_manifest

end
