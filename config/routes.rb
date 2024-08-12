Rails.application.routes.draw do
  root 'documents#index'
  get '/signup' => 'users#new'
  post '/signup' => 'users#create'
  get '/profile' => 'users#edit'
  patch '/profile' => 'users#update'

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'

  get '/share/:id', to: 'documents#shared', as: 'shared'
  get '/share/documents/:id', to: 'documents#show', as: 'download_unknown'
  get '/document/:id', to: 'documents#download', as: 'download_document'
  get '/document/new', to: 'documents#new', as: 'new_document'
  post '/document', to: 'documents#create'
  patch '/document/:id', to: 'documents#update', as: 'document_update'
  delete '/document/:id', to: 'documents#destroy', as: 'document_delete'
  # resource  :document, except: [:new, :edit]
end
