Rails.application.routes.draw do
  get 'homepage/index'
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

  resources :reservation, only: [:destroy, :show]

  root "homepage#index" 

  get "/auth/:provider/callback" => "sessions#create_from_omniauth"

  get "/:username" => "users#new"

  patch "/listing/:id/verified" => "listing#verify"
  patch "/listing/:id/unverified" => "listing#unverify"

  post "/:username/avatar" => "users#upload_avatar"
end
