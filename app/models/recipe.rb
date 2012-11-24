class Recipe < ActiveRecord::Base
  attr_accessible :fg, :ibu, :name, :og, :style_id, :user_id, :fermentable_manifests_attributes, :hop_manifests_attributes, :final_volume, :description

  validates :final_volume, presence: true, :numericality => { greater_than: 0 }
  validates :name, :description, presence: true
  has_many :hop_manifests, dependent: :destroy
  has_many :fermentable_manifests, dependent: :destroy
  has_many :hops, through: :hop_manifests
  has_many :fermentables, through: :fermentable_manifests
  accepts_nested_attributes_for :fermentable_manifests, :reject_if => lambda { |a| a[:amount].blank? }
  accepts_nested_attributes_for :hop_manifests, :reject_if => lambda { |a| a[:aau].blank? or a[:boil_time].blank? }

end
