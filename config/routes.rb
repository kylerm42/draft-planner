Rails.application.routes.draw do
  scope '/api', defaults: { format: :json } do
    mount_devise_token_auth_for 'User', at: '/auth'
    resources :collections, only: [:index, :create, :show, :update, :destroy] do
      get ':position', to: 'sheets#show'
    end
    resources :players, only: :show
    resources :sheets, only: [:update, :destroy] do
      resources :tags, only: [:index, :create, :update]
    end
    resources :tags, only: :show
  end
end
