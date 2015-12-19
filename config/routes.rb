Rails.application.routes.draw do
  root "top#index"
  resources :members do 
  	collection{ get :search}
  end 

end
