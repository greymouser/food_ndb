module FoodNdb
  class Weight < ActiveRecord::Base
  	self.primary_keys = :nutrient_databank_number, :sequence

    belongs_to :food, foreign_key: :nutrient_databank_number
  end
end
