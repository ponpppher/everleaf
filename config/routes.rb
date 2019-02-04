Rails.application.routes.draw do
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  
  namespace :admin do
    resources :users
  end

  root to: 'tasks#index'

  resources :tasks do
    # confirm_new_task POST /tasks/new/confirm(.:format) tasks#confirm_new
    post :confirm, action: :confirm_new, on: :new
  end
end
