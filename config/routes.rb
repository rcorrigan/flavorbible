Rails.application.routes.draw do
  resources :ingredients
  get 'welcome/index'
  get 'ingredients/index'
  get 'ingredients/show'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :flavorgraphs
  root 'flavorgraphs#new'

  resources :flavorgraphs do
    get :autocomplete_ingredient_id, on: :collection
  end
  resources :ingredients do
    get :autocomplete_ingredient_id, on: :collection
  end
end
