Rails.application.routes.draw do

  resources :labels, only:[:show]

  resources :topics do
    resources :posts, except: [:index]  #  GET asks for data, a POST creates data, a PATCH or PUT updates data, and a DELETE deletes data
  end
  
  resources :posts, only: [] do  #we don't want to create any /posts/:id routes, just posts/:post_id/comments routes
    resources :comments, only: [:create, :destroy]
    resources :favorites, only: [:create, :destroy]
    post '/up-vote' => 'votes#up_vote', as: :up_vote
    post '/down-vote' => 'votes#down_vote', as: :down_vote
  end
  resources :users, only: [:new, :create, :show]
  resources :sessions, only: [:new, :create, :destroy]
  get 'welcome/about'
  post 'users/confirm' => 'users#confirm'
  #get 'welcome/faq'
  root to: 'welcome#index'
  
  namespace :api do 
    namespace :v1 do 
      resources :users, only: [:show, :index, :create, :update]
      resources :topics, except: [:edit, :new]
    end
  end

  
end
