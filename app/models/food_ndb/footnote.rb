module FoodNdb
  class Footnote < ActiveRecord::Base
    belongs_to :food, foreign_key: 'nutrient_databank_number'
  end
end

