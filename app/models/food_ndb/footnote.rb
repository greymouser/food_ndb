module FoodNdb
  class Footnote < ActiveRecord::Base
  	self.primary_key = nil

    belongs_to :food, foreign_key: 'nutrient_databank_number'
    belongs_to :nutrient, foreign_key: 'nutrient_number', primary_key: :number
  end
end
