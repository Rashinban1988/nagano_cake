Rails.application.routes.draw do

  namespace :public do
    get 'items/index'
    get 'items/show'
  end
  namespace :admin do

    resources :genres, only: [:index, :create, :edit, :update]
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
    resources :customers, only: [:index, :edit, :show, :update]
    resources :orders, only: [:index, :show, :update]
    resources :order_items, only: [:update]

  end

  namespace :public do

    resources :addresses, only: [:index, :edit, :create, :update, :destroy]
    resources :items, only: [:index, :show]

  end


  get '/admin' => 'admin/homes#top'

  root 'public/homes#top'

  #顧客情報public
  get '/about' => 'public/homes#about'
  get '/customers/my_page/:id' => "public/customers#show", as: "customer"
  get '/customers/my_pages/:id/edit' => "public/customers#edit", as: "edit_customer"
  patch '/customers/my_pages/:id' => "public/customers#update", as: "update_customer"
  get '/customers/my_pages/:id/unsubscribe_confirmation' => "public/customers#unsubscribe_confirmation", as: "unsubscribe_confirmation"
  patch '/customers/my_pages/:id/is_deleted' => "public/customers#unsubscribe", as: "unsubscribe"

  # 顧客用
  # URL /customers/sign_in ...
  devise_for :customers,skip: [:passwords],  controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    registrations: "admin/registrations",
    sessions: "admin/sessions"
  }

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
