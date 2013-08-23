Rails.application.routes.draw do
  #resources :foods

  mount FoodNdb::Engine => "/food_ndb"

  match "/test/:id" => "test#index"
end
