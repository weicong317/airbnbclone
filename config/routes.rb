Rails.application.routes.draw do
  get "/listing/:listing_id/reservation/:id/payment/new" => "braintree#new"
  post "/listing/:listing_id/reservation/:id/payment/checkout" => "braintree#checkout"
  get 'homepage/about'
  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "clearance/sessions", only: [:create]

  resources :users, only: [:create] do
    resource :password,
      controller: "clearance/passwords",
      only: [:create, :edit, :update]
  end

  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"
  get "/sign_up" => "clearance/users#new", as: "sign_up"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :listing do
    resources :reservation, only: [:create, :index, :new]
  end

  resources :reservation, only: [:destroy, :show, :update]

  root "homepage#index" 

  get "/auth/:provider/callback" => "sessions#create_from_omniauth"

  get "/users" => "homepage#users"
  get "/pending" => "homepage#pending"
  get "/verified" => "homepage#verified"
  get "/search" => "listing#filter"
  get "/search/autocomplete" => "listing#autocomplete"

  get "/:username" => "users#new"
  delete "/:username" => "users#destroy"
  post "/:username" => "users#edit"

  patch "/listing/:id/verified" => "listing#verify"
  patch "/listing/:id/unverified" => "listing#unverify"

  post "/:username/avatar" => "users#upload_avatar"
end
