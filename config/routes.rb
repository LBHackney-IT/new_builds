Rails.application.routes.draw do
  devise_for :users
  resources :issues
  root to: 'issues#index'
end
