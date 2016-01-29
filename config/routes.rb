Rails.application.routes.draw do
  root "top#index"
  resources :members do 
  	collection{ get :search}
  end 
  resources :articles

  resource :session, only:[:create, :destroy]

end
