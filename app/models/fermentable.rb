class Fermentable < ActiveRecord::Base
  attr_accessible :name, :ppg, :unit_price, :weight_unit
end
