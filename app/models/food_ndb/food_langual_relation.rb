module FoodNdb
  class FoodLangualRelation < ActiveRecord::Base
  	self.table_name = :food_ndb_foods_languals
    self.primary_keys = :nutrient_databank_number,:langual_code

    belongs_to :food, foreign_key: :nutrient_databank_number
    belongs_to :langual, foreign_key: :langual_code, primary_key: :code
  end
end
