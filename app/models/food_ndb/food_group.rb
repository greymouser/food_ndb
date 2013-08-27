module FoodNdb
  class FoodGroup < ActiveRecord::Base
    self.primary_key = :code

    has_many :foods, foreign_key: 'food_group_code'
  end
end
