PhotoMania::Application.routes.draw do
  
  get "users/home"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'users#home'
	match 'showcover/:data' => 'photo#showcover'
  	match 'users/signup' => 'users#signup'
	match 'users/home' => 'users#home'
	match 'users/authenticate' => 'users#authenticate'
	match 'photo/upload'=>'photo#upload'
	match 'users/remalb' => 'users#remalb'
	match 'photo/show1'=>'photo#show1'
	match 'photo/products'=>'photo#products'
	match 'photo/all'=>'photo#all'
	match 'users/photoframes' => 'users#photoframes'
	match 'photoframes' => 'users#photoframes'
	match 'photomugs' => 'users#photomugs'
	match 'tshirts' => 'users#tshirts'
	match 'users/logout' => 'users#logout'
  	match 'users/showall' => 'users#showall'
	match 'users/showalb' => 'users#showalb'
  	match 'photo/showpics' => 'photo#showpics'
  	match 'photo/rem' => 'photo#rem'
  	resources :photo
	resources :users

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
