Rails.application.routes.draw do

  #管理page
  namespace :admin do

    resources :genres, only: [:index, :create, :edit, :update]
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
    resources :customers, only: [:index, :edit, :show, :update]
    resources :orders, only: [:index, :show, :update]
    resources :order_items, only: [:update]

  end

  #管理page home
  get '/admin' => 'admin/homes#top'

  #顧客page home
  root 'public/homes#top'
  get '/about' => 'public/homes#about'

  #顧客page customer
  get '/customers/my_page/:id' => "public/customers#show", as: "customer"
  get '/customers/my_pages/:id/edit' => "public/customers#edit", as: "edit_customer"
  patch '/customers/my_pages/:id' => "public/customers#update", as: "update_customer"
  get '/customers/my_pages/:id/unsubscribe_confirmation' => "public/customers#unsubscribe_confirmation", as: "unsubscribe_confirmation"
  patch '/customers/my_pages/:id/is_deleted' => "public/customers#unsubscribe", as: "unsubscribe"

  #顧客page address
  get '/addresses' => "public/addresses#index", as: "addresses"
  get '/addresses/:id/edit' => "public/addresses#edit", as: "edit_addresses"
  post '/addresses' => "public/addresses#create"
  patch '/addresses/:id' => "public/addresses#update"
  delete '/addresses/:id' => "public/addresses#destroy"

  #顧客page orders
  get '/orders/new' => "public/orders#new", as: "new_order"
  get '/orders/:id/show' => "public/orders#show", as: "order"
  get '/orders' => "public/orders#index", as: "orders"
  post '/orders' => "public/orders#create"
  get '/orders/complete' => "public/orders#complete", as: "complete_order"
  post '/orders/order_confirmation' => "public/orders#order_confirmation", as: "order_confirmation_order"

  #顧客page item
  get '/items' => "public/items#index", as: "items"
  get '/items/:id' => "public/items#show", as: "item"

  #顧客page cart_item
  get 'cart_items' => "public/cart_items#index", as: "cart_items"
  patch 'cart_items/:id' => "public/cart_items#update", as: "update_cart_items"
  post 'cart_items' => "public/cart_items#create"
  delete 'cart_items_:id' => "public/cart_items#destroy_some", as: "destroy_cart_item"
  delete 'cart_items' => "public/cart_items#destroy_all", as: "destroy_cart_items"

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
