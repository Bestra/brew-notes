class Recipe < ActiveRecord::Base
  attr_accessible :fg, :ibu, :name, :og, :style_id, :user_id
end
