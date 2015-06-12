Rails.application.routes.draw do
  scope '/api', defaults: { format: :json } do
    mount_devise_token_auth_for 'User', at: '/auth'
    resources :collections, only: [:index, :create, :show, :update, :destroy]
    resources :players, only: :show
    resources :sheets, only: [:show, :update, :destroy] do
      resources :tags, only: [:index, :create, :update]
    end
    resources :tags, only: :show
  end
end
