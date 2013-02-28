module FoodNdb
  class Langual < ActiveRecord::Base
    self.primary_key = 'code'

    has_and_belongs_to_many :foods, join_table: 'food_ndb_foods_languals',
                            foreign_key: 'langual_code', association_foreign_key: 'nutrient_databank_number'
  end
end
