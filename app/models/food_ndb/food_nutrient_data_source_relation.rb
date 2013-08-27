module FoodNdb
  class FoodNutrientDataSourceRelation < ActiveRecord::Base
  	self.table_name = :food_ndb_food_nutrients_data_sources
    self.primary_keys = :nutrient_databank_number,:nutrient_number,:data_source_id

    belongs_to :food_nutrient, foreign_key: [:nutrient_databank_number,:nutrient_number]
    belongs_to :data_source, foreign_key: :data_source_id, primary_key: :id
  end
end
