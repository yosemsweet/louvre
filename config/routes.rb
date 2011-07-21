Louvre::Application.routes.draw do

  resources :widgets

  resources :canvae

  resources :canvae do
		resources :pages
	end

  root :to => "static#index"
  match 'thankyou' => "static#thankyou"

	match "/auth/:provider/callback" => "sessions#create"  
	match "/logout" => "sessions#destroy", :as => :logout 

end
