module FoodNdb
  class FoodNutrient < ActiveRecord::Base
  	self.primary_keys = :nutrient_databank_number, :nutrient_number

    belongs_to :food, foreign_key: :nutrient_databank_number
    belongs_to :nutrient, foreign_key: :nutrient_number, primary_key: :number
    belongs_to :source, foreign_key: :source_code, primary_key: :code
    belongs_to :derivation, foreign_key: :derivation_code, primary_key: :code

	has_many :food_nutrient_data_source_relations, foreign_key: [:nutrient_databank_number,:nutrient_number]
	has_many :data_sources, through: :food_nutrient_data_source_relations
  end
end
