Rails.application.routes.draw do
	 devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users
  resources :books do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
    end
  root 'home#top'
  get '/home/about' => 'home#about'
end
