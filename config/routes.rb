PostitTemplate::Application.routes.draw do
  
  get '/register', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  
  resources :posts, except: [:destroy] do
    
    resources :votes
    
    resources :comments, only: [:create] do
      # will recognise /posts/id/comments/id/vote vote with POST and route to vote method
      # in CommentsController
      post :vote, on: :member 
    end
  end
    
  resources :categories, only: [:new, :create, :show]
  
  resources :users, only: [:create, :show, :edit, :update ]

  root to: 'posts#index'
  
end
