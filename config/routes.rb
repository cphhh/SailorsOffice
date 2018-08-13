Rails.application.routes.draw do
  get 'invoices/new'

  get 'invoices/show'

  get 'invoices/edit'

  get 'invoices/index'

  get 'regattas/new'

  root 'static_pages#home'

  get 'static_pages/home'

  get  '/signup',  to: 'users#new'

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  resources :users
  resources :regattas
  resources :invoices
end
