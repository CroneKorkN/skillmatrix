Rails.application.routes.draw do
  resources :user_skills
  resources :users
  resources :skills
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "user_skills#index"
end
