Louvre::Application.routes.draw do

  resources :canvae do
		resources :pages do
		  member do
		    get 'widgets'
		    get 'versions'
	    end
	  end
	
	  resources :widgets do
			member do
				put 'update_position'
			end
		end
		
		
	end

  root :to => "static#index"
  match 'thankyou' => "static#thankyou"

	match "/auth/:provider/callback" => "sessions#create"  
	match "/logout" => "sessions#destroy", :as => :logout 

end
