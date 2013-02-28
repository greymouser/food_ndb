Rails.application.routes.draw do
  mount FoodNdb::Engine => "/food_ndb"

  match "/test/:id" => "test#index"
end
