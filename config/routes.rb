Rails.application.routes.draw do
  root 'documents#index'
  get '/signup' => 'users#new'
  post '/signup' => 'users#create'
  # get '/profile' => 'users#show', :as => :user
  get '/profile/edit' => 'users#edit'
  patch '/profile' => 'users#update'

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'

  resource  :document, except: [:new, :edit]
end
