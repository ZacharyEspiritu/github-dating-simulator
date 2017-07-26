Rails.application.routes.draw do
  resources :parties do
    get :manage
    post :add_user
    post :start
    post :remove_user
  end
  resources :user_data
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root "pages#home"

  post "analyze", to: "pages#analyze"
  get "analysis", to: "pages#analysis"

  get "practical", to: "pages#practical"
  post "analyze_multiple", to: "pages#analyze_multiple"

  get "multiple", to: "pages#multiple"

  resources :result
end
