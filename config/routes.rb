Rails.application.routes.draw do
  root 'users#new'


  resources :searches, only: [:new, :create, :show]
  resources :users, only: [:new, :create]


  get '/search', to: 'searches#new'
  post '/search/results', to: 'searches#create'
  get '/search/results', to: 'searches#create'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
