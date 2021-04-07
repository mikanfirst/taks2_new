Rails.application.routes.draw do
  devise_for :users
  resources :users,only: [:show,:index,:edit,:update]
  post 'follow/:id' => 'relationships#follow', as: 'follow' #　フォローする
  post 'unfollow/:id' => 'relationships#unfollow', as: 'unfollow' #フォローを外す
  resources :books do
    resource :favorites,only: [:create, :destroy]
    resources :post_comments,only: [:create, :destroy]
  end
  root 'homes#top'
  get 'home/about' => 'homes#about'
end