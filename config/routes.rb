Rails.application.routes.draw do

  root 'static_pages#home'

  get 'static_pages/home'

  get  '/signup',  to: 'users#new'

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  resources :users
  resources :regattas
  get '/joinregattas',  to: 'regattas#joinregattas'
  get '/myregattas',  to: 'regattas#myregattas'

  resources :invoices
  get '/myinvoices',  to: 'invoices#myinvoices'

end
