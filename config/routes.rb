Louvre::Application.routes.draw do

  root :to => "static#index"
  
  match "/auth/:provider/callback" => "sessions#create"  
	  match "/logout" => "sessions#destroy", :as => :logout

  resources :comments
  resources :emails
    
  match "/users/hud/" => "users#hud", :as => :user_hud
  match "/users/edit/" => "users#edit", :as => :user_edit
  
  resources :canvae do
    resource :canvas_follow
		resources :pages do
		  member do
        get 'versions'
	    end
	  end
	end

  match "/widgets/create_via_email"  => "widgets#create_via_email"
  resources :widgets do
    collection do    
      get 'for_page/:page_id/:display' => "widgets#for_page"
      get 'for_canvas/:canvas_id/:display' => "widgets#for_canvas"
    end
    member do
      post 'copy_to_page/:page_id' => "widgets#copy_to_page"
      put 'move/:position' => "widgets#move"
    end
  end
	
  match 'discussions/:type/:id' => "discussions#show", :as => :discussion

	post '/follows' => "follows#create"
	delete '/follows' => "follows#delete"
	
	get '/tags' => "tags#index"

end
