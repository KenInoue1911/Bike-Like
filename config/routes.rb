Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  get '/about' => 'homes#about'
  get '/mypage' => 'homes#mypage'
  get 'posts/top' => 'posts#top'
  get 'posts/favorite' => 'posts#favorite', as: 'favorite'
  post '/homes/guest_sign_in', to: 'homes#guest_sign_in'
  # 退会確認画面
  get '/users/:id/unsubscribe' => 'users#unsubscribe', as: 'unsubscribe'

  resources :users do
    resource :relationships, only: %i[create destroy]
    get 'relationships/followings' => 'relationships#followings', as: 'follows'
    get 'relationships/followers' => 'relationships#followers', as: 'followers'
  end
  resources :posts do
    resources :post_comments # , only: [:create, :destroy]
    resource :favorites, only: %i[create destroy]
  end
  resources :messages, only: [:create]
  resources :rooms, only: %i[index show create]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
