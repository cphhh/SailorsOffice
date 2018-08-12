Rails.application.routes.draw do
  get 'regattas/new'

  root 'static_pages#home'

  get 'static_pages/home'
  get '/myregattas', to: 'static_pages#myregattas', as: 'myregattas'

  get  '/signup',  to: 'users#new'

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  resources :regattas

  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
