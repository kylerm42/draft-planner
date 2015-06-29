Rails.application.routes.draw do
  scope '/api', defaults: { format: :json } do
    mount_devise_token_auth_for 'User', at: '/auth'
    resources :collections,   only: [:index, :create, :show, :update, :destroy]
    resources :players,       only: [:show, :index]
    resources :sheets,        only: [:show, :update, :destroy] do
      resources :tags,        only: [:index, :create, :update]
    end
    resources :tags,          only: :show

    scope 'admin' do
      get '/stats', to: 'admin#stats'
      resources :players,     only: [:create, :update]
    end
  end
end
