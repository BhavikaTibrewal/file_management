Rails.application.routes.draw do
  resource :session, :users
  root 'documents#index'
  get '/signup' => 'users#index'
  post '/signup' => 'users#create'
  get '/profile' => 'users#show', :as => :user
  get '/profile/edit' => 'users#edit'
  patch '/profile' => 'users#update'

  get '/login' => 'sessions#index'
  post '/login' => 'sessions#index'
  delete '/logout' => 'sessions#destroy'
end
