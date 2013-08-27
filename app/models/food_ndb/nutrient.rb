module FoodNdb
  class Nutrient < ActiveRecord::Base
    self.primary_key = :number

    has_many :food_nutrients, foreign_key: :nutrient_number
    has_many :foods, through: :food_nutrients
  end
end

