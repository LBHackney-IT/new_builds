Rails.application.routes.draw do
  devise_for :users
  resources :schemes, only: [:index] do
    resources :issues do
      resources :comments, only: [:create]
      collection do
        get :type_chart
      end
    end
  end
  root to: 'schemes#index'
end
