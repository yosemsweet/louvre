Louvre::Application.routes.draw do
  resources :comments

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
				post 'clone_widget'
			end
		end
		match '/discussions' => "discussions#show"
	end

  root :to => "static#index"
  match 'thankyou' => "static#thankyou"

	match "/auth/:provider/callback" => "sessions#create"  
	match "/logout" => "sessions#destroy", :as => :logout 
	
	match "/next_scroll_widgets" => "widgets#next_for_scroll"
	match "/scrolly" => "static#scrolly"
	match "/scrolly2" => "static#scrolly2"
	match "/scrollywidgets" => "static#scrolly_widgets"
end
