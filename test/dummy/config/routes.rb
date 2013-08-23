Rails.application.routes.draw do
  #resources :foods

  mount FoodNdb::Engine => "/food_ndb"

  get "/test/:id" => "test#index"
end
