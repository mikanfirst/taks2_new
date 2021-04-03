Rails.application.routes.draw do
  devise_for :users
  resources :users,only: [:show,:index,:edit,:update] do
    resources :post_comments,only: [:create, :destroy]
  end
  resources :books
  root 'homes#top'
  get 'home/about' => 'homes#about'
end