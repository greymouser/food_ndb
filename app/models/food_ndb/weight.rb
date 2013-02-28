module FoodNdb
  class Weight < ActiveRecord::Base
    belongs_to :food
  end
end
