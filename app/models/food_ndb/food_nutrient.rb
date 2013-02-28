module FoodNdb
  class FoodNutrient < ActiveRecord::Base
    belongs_to :food, foreign_key: 'nutrient_databank_number'
    belongs_to :nutrient, foreign_key: 'nutrient_number'
    belongs_to :source, foreign_key: 'source_code'
    belongs_to :derivation, foreign_key: 'derivation_code'
  end
end
