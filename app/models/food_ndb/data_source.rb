module FoodNdb
  class DataSource < ActiveRecord::Base
    self.primary_key = :id

	has_many :food_nutrient_data_source_relations, foreign_key: :data_source_id
	has_many :food_nutrients, through: :food_nutrient_data_source_relations
  end
end
