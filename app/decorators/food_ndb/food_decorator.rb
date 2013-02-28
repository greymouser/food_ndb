module FoodNdb
  class FoodDecorator < Draper::Decorator
    include Draper::LazyHelpers

    delegate_all

    def display_nutrient(nutrient)
      fn = source.get_nutrient(nutrient)
      if fn.nil?
        'n/a'
      else
        "#{number_to_human(fn[:value])}#{fn[:units]}"
      end
    end
  end
end
