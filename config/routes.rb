Rails.application.routes.draw do
  scope '/api', defaults: { format: :json } do
    mount_devise_token_auth_for 'User', at: '/auth'
    resources :collection, only: [:index, :create, :show, :update, :destroy]
  end
end
