module FoodNdb
  class Derivation < ActiveRecord::Base
    self.primary_key = :code

    has_many :food_nutrients, foreign_key: :derivation_code
    has_many :foods, through: :food_nutrients
  end
end
