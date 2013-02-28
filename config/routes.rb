FoodNdb::Engine.routes.draw do
  resources :foods

  root :to => 'foods#index'
end
