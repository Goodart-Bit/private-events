Rails.application.routes.draw do
  devise_for :users
  get 'users/show'
  resources :events, only: [:index, :new, :create, :show, :destroy]
  root to: "events#index"
  get 'event=:event_id/setup_attendances', to: 'attendances#new', as: 'setup_attendances'
  get 'event=:event_id/attendances', to: 'attendances#index', as: 'attendances'
  post 'event=:event_id/attendances', to: 'attendances#create'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
