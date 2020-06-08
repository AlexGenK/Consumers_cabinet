Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }

  resources :users
  
  resources :consumers do
    resources :contracts do
      resources :counters do
        resources :powers
      end
    end
    resources :certificates, only: [:show]
  end

  namespace :admin do
    get 'filling_consumers',      to: 'filling_consumers#set_params'
    post 'filling_consumers',     to: 'filling_consumers#start'
    get 'filling_consumptions',   to: 'filling_consumptions#set_params'
    post 'filling_consumptions',  to: 'filling_consumptions#start'
    get 'filling_plan',           to: 'filling_plan#set_params'
    post 'filling_plan',          to: 'filling_plan#start'
    get 'filling_certificates',   to: 'filling_certificates#start'
    get 'statistic',              to: 'statistic#consumers_counter'
    resource :payment
  end

  root to: 'consumers#index'
end
