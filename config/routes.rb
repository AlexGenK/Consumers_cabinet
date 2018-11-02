Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :consumers do
    resources :counters do
      resources :powers
    end
  end

  namespace :admin do
    get 'filling_consumers', to: 'filling_consumers#set_params'
    post 'filling_consumers', to: 'filling_consumers#start'
    get 'filling_consumptions', to: 'filling_consumptions#set_params'
    post 'filling_consumptions', to: 'filling_consumptions#start'
  end

  root to: 'consumers#index'
end
