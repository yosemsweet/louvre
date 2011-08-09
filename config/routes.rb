Louvre::Application.routes.draw do
  resources :comments
  
  resources :canvae do
    resource :canvas_follow
		resources :pages do
		  member do
        get 'versions'
	    end
	  end
	end

  resources :widgets do
    collection do    
      get 'for_page/:page_id/:display' => "widgets#for_page"
      get 'for_canvas/:canvas_id/:display' => "widgets#for_canvas"
    end
  end
  
	
  match 'discussions/:type/:id' => "discussions#show", :as => :discussion

  resources :users do
    member do
      get 'hud'
    end  
  end

  root :to => "static#index"
  match 'thankyou' => "static#thankyou"
  match 'testpage' => "static#testpage"

	match "/auth/:provider/callback" => "sessions#create"  
	match "/logout" => "sessions#destroy", :as => :logout 
	
  # match "/next_scroll_widgets" => "widgets#next_for_scroll"
  # match "/scrollywidgets" => "static#scrolly_widgets"
  # 
  # match "/new_canvas_widgets" => "widgets#new_canvas_widgets"

  match "/test_widget" => "static#test_widget"

end
