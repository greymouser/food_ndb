module FoodNdb
  class Source < ActiveRecord::Base
    self.primary_key = 'code'

    has_many :food_nutrients, foreign_key: 'source_code'
    has_many :foods, through: :food_nutrients, foreign_key: 'source_code'
  end
end
