Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'auth', controllers: {
        registrations: 'api/v1/auth/registrations'
      }
      namespace :auth do
        resources :sessions, only: %i[index]
      end

      resources :users, only: [:index, :show, :update] do
        resources :reservations, only: [:create, :destroy]
          get 'reservings' => 'reservations#reservings', as: "reservings"
          get 'reservers' => 'reservations#reservers', as: "reservers"
      end
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
