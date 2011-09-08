Louvre::Application.routes.draw do

  root :to => "static#index"
  
  match "/auth/:provider/callback" => "sessions#create"  
	  match "/logout" => "sessions#destroy", :as => :logout

  resources :comments
  resources :emails
  resources :feedbacks
    
  match "/users/hud/" => "users#hud", :as => :hud_user
  match "/users/edit/" => "users#edit", :as => :edit_user
  
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
      put 'remove_answer/:answer_id' => "widgets#remove_answer"
    end
  end
	
  match 'discussions/:type/:id' => "discussions#show", :as => :discussion

	post '/follows' => "follows#create"
	delete '/follows' => "follows#delete"
	
	get '/tags' => "tags#index"

  # Delete Us!
  match '/test' => 'static#test'
  match '/testdata' => 'static#testdata'
end
