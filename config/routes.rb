Rails.application.routes.draw do
  root 'users#new'


  resources :searches, only: [:new, :create, :show]
  resources :users, only: [:new, :create, :show]


  get '/search', to: 'searches#new'
  post '/search/results', to: 'searches#create'
  # need a 'get' request with same results in case users refresh page
  get '/search/results', to: 'searches#create'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
