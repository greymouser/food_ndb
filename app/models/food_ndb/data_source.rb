module FoodNdb
  class DataSource < ActiveRecord::Base
    self.primary_key = 'id'

    has_and_belongs_to_many :foods, join_table: 'food_ndb_food_nutrients_data_sources',
                            foreign_key: 'data_source_id', association_foreign_key: 'nutrient_databank_number'
  end
end

