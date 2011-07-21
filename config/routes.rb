Louvre::Application.routes.draw do
  resources :canvae do
		resources :pages
    resources :things do
	    resources :comments
    end
	end

  root :to => "static#index"
  match 'thankyou' => "static#thankyou"

	match "/auth/:provider/callback" => "sessions#create"  
	match "/logout" => "sessions#destroy", :as => :logout 

end
