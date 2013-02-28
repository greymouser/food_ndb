module FoodNdb
  module FoodsHelper
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
