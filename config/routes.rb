Rails.application.routes.draw do
  root "top#index"
  get "about" => "top#about", as: "about"
  get "bad_request" => "top#bad_request"
  get "internal_server_error" => "top#internal_server_error"


  resources :members, only:[:index, :show] do
    collection{ get :search}
    resources :entries, only: [:index]
  end

  resources :articles, only:[:index, :show]
  resources :entries do
    member {patch "like", "unlike"}
    collection{get "voted"}
  end

  namespace :admin do
    root "top#index"
    resources :members do
      collection{ get :search}
    end
    resources :articles
  end

  resource :session, only: [:create, :destroy]
  resource :account, only:[:show, :edit, :update]

  match "*anything" => "top#not_found", via: [:get, :post, :patch, :delete]
end
