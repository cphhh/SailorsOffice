Rails.application.routes.draw do

  post 'slack/create'
	post 'slack/create_deposit'
	post 'slack/indexregatta'
	post 'slack/help'

  root 'static_pages#home'

  get 'static_pages/home'

  get  '/signup',  to: 'users#new'

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  resources :users
  resources :regattas
	resources :deposits
  get '/joinregattas',  to: 'regattas#joinregattas'
  get '/myregattas',  to: 'regattas#myregattas'

  resources :invoices
  get '/myinvoices',  to: 'invoices#myinvoices'
  get '/regattainvoices',  to: 'invoices#regattainvoices'

  resources :balances do
    put :updateclosed
  end

end
