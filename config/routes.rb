Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :consumers do
    resources :counters do
      resources :powers
    end
  end

  root to: 'consumers#index'
end
