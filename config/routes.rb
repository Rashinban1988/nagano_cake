Rails.application.routes.draw do


  namespace :admin do

    resources :genres, only: [:index, :create, :edit, :update]
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
    resources :customers, only: [:index, :edit, :show, :update]
    resources :orders, only: [:index, :show, :update]
    resources :order_items, only: [:update]

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

  get '/addresses' => "public/addresses#index", as: "addresses"
  get '/addresses/:id/edit' => "public/addresses#edit", as: "edit_addresses"
  post '/addresses' => "public/addresses#create"
  patch '/addresses/:id' => "public/addresses#update"
  delete '/addresses/:id' => "public/addresses#destroy"

  get '/items' => "public/items#index", as: "items"
  get '/items/:id' => "public/items#show", as: "item"

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
