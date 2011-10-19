Louvre::Application.routes.draw do

  root :to => "static#redesign"
  
  match "coming_soon" => "static#coming_soon"
  match "coming_soon_community" => "static#coming_soon_community"
  match "coming_soon_ideas" => "static#coming_soon_ideas"
  match "coming_soon_feed" => "static#coming_soon_feed"
  match "coming_soon_publishing" => "static#coming_soon_publishing"
  
  match "/auth/:provider/callback" => "sessions#create"  
	match "/login" => "static#login"
	match "/logout" => "sessions#destroy", :as => :logout

  resources :comments
  resources :emails
  resources :feedbacks
    
	scope :path => "/users", :controller => :users do
  	get "/" => "users#index", :as => :users
		put "/:id" => "users#update"
  	get "/edit" => "users#edit", :as => :edit_user
	end
  
  resources :canvae do
		member do 
			get 'banned' => "canvae#banned"
			post 'banned' => "canvae#banned_create"
			delete 'banned' => "canvae#banned_destroy"
			get 'members' => "canvae#members"
			get 'join' => "canvae#members_create"
			post 'members' => "canvae#members_create"
			get 'applicants'
	    #delete 'applicants/:user_id' => "canvae#applicants_delete"
		end
		
    resource :canvas_follow
		
		resources :pages do
		  member do
        get 'versions'
	    end
	  end

	  member do
	    get 'applicants'
	    post 'applicants' => 'canvae#applicants_create'
	    post 'members' => "canvae#members_create"
    end
	end
	
  delete "/canvae/:id/applicants/:user_id" => "canvae#applicants_delete", :as => :applicants_delete

  match "/widgets/:id/tags"  => "widgets#widget_tags"
  match "/widgets/create_via_email"  => "widgets#create_via_email"
  match "/events"  => "events#index"
  match "/event_count"  => "events#count"
  
  resources :widgets do
    collection do    
      get 'for_page/:page_id/:display' => "widgets#for_page"
      get 'for_canvas/:canvas_id/:display' => "widgets#for_canvas"
    end	
    member do
			get 'edit_history' => "widgets#edit_history"
      post 'copy_to_page/:page_id' => "widgets#copy_to_page"
      put 'move/:position' => "widgets#move"
      put 'remove_answer/:answer_id' => "widgets#remove_answer"
    end
  end
	
  match 'discussions/:type/:id' => "discussions#show", :as => :discussion

	post '/follows' => "follows#create"
	delete '/follows' => "follows#delete"
	
	get '/tags' => "tags#index"

end
