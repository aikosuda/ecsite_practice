Rails.application.routes.draw do
  
  root 'home#top'
  get 'home/about' => 'home#about'

  #会員用サイト

  devise_for :users, controllers: {
  	registrations: 'users/registrations',
  	passwords: 'users/passwords',
  	sessions: 'users/sessions'}

  resources :users, only: [:show, :edit, :update] do
  	#退会処理
  	member do
	  get 'check'
  	patch 'withdraw'
  	end
  end

  resources :products, only: [:show, :index]
  resources :genres, only: [:show]
  resources :orders, only: [:new, :index, :create, :show]
  post 'orders/confirm' => 'orders#confirm'
  get 'orders/thanks' => 'orders#thanks'
  resources :shippings, only: [:index, :create, :edit, :update, :destroy]
  
  resources :cart_items, only: [:create, :index, :update, :destroy] do
  	#カート空にする
  	collection do
      delete 'destroy_all'
    end
  end

  #管理者サイト

  devise_for :admins, controllers: {
  		registrations: 'admins/registrations',
  		passwords: 'admins/passwords',
  		sessions: 'admins/sessions'}


  namespace :admins do
  	get 'home/top' => 'home#top'
  	resources :users, only: [:index, :show, :edit, :update]
  	resources :products, only: [:index, :new, :create, :show, :edit, :update]
  	resources :genres, only: [:index, :create, :edit, :update]
  	resources :orders, only: [:index, :show, :update]
    resources :order_details, only: [:update]
  end


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
