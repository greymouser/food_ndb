require "activerecord-import"

module FoodNdb
  class Food < ActiveRecord::Base
    self.primary_key = :nutrient_databank_number

    belongs_to :group, class_name: FoodGroup, foreign_key: :food_group_code, primary_key: :code

    has_many :footnotes, foreign_key: 'nutrient_databank_number'

    has_many :food_nutrients, foreign_key: :nutrient_databank_number
    has_many :nutrients, through: :food_nutrients
    has_many :sources, through: :food_nutrients
    has_many :derivations, through: :food_nutrients
    has_many :data_sources, through: :food_nutrients

    has_many :weights, -> { order('sequence ASC') }, foreign_key: :nutrient_databank_number

    has_many :food_langual_relations, foreign_key: :nutrient_databank_number
    has_many :languals, through: :food_langual_relations

    # has_and_belongs_to_many :languals, join_table: 'food_ndb_foods_languals',
    #                         foreign_key: 'nutrient_databank_number', association_foreign_key: 'langual_code'

    def calories_protein
      get_nutrient(:PROCNT)[:value] * (self.protein_factor || 4)
    end

    def calories_carbohydrate
      get_nutrient(:CHOCDF)[:value] * (self.carbohydrate_factor || 4)
    end

    def calories_fat
      get_nutrient(:FAT)[:value] * (self.fat_factor || 9)
    end

    def calories
      get_nutrient(:ENERC_KCAL)[:value]
    end

    def percent_fat
      self.calories_fat.to_f / self.calories.to_f * 100.0
    end

    def get_nutrient(infoods_tagname)
      fn = FoodNdb::FoodNutrient.
            includes(:nutrient).
            where("food_ndb_food_nutrients.nutrient_databank_number = ? AND food_ndb_nutrients.infoods_tagname = ?",
              self.nutrient_databank_number, infoods_tagname.to_s).
            references(:food_ndb_nutrients).
            first
      return nil if fn.nil?
      {value: fn.value, units: fn.nutrient.units}
    end
  end
end
