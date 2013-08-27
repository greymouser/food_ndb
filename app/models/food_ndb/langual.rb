module FoodNdb
  class Langual < ActiveRecord::Base
    self.primary_key = :code

    has_many :food_langual_relations, foreign_key: :langual_code
    has_many :foods, through: :food_langual_relations
  end
end
