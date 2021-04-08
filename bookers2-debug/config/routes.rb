Rails.application.routes.draw do
  devise_for :users

  root 'homes#top'
  get 'home/about' => 'homes#about'

  resources :users, only: [:show,:index,:edit,:update] do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings' #　フォローする
    get 'followers' => 'relationships#followers', as: 'followers' #フォローを外す
  end
  resources :books do
    resource :favorites,only: [:create, :destroy]
    resources :post_comments,only: [:create, :destroy]
  end

end