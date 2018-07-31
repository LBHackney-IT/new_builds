Rails.application.routes.draw do
  devise_for :users
  resources :schemes, only: [:index] do
    resources :issues
  end
  root to: 'schemes#index'
end
