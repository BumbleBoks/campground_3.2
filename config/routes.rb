Campground::Application.routes.draw do
  resources :users
  
  resources :sessions, only: [:new, :create, :destroy]
  
  root to: 'static_pages#home';
  match '/about', to: 'static_pages#about'
  match '/contact', to: 'static_pages#contact'
    
  get 'join', to: 'users#new', as: 'join'
  get 'login', to: 'sessions#new', as: 'login'
  delete 'logout', to: 'sessions#destroy', as: 'logout'
  
  namespace :common do
    resources :trails
  end
  
  namespace :community do
    resources :updates, only: [ :create]
  end
  
  get 'favorites/show', to: 'corner/favorites#show', as: 'favorites/show'
  get 'favorites/new', to: 'corner/favorites#new', as: 'favorites/new'
  namespace :corner do
    resources :favorites, only: [:create] 
    post 'favorites/add_trail'
    post 'favorites/remove_trail'
  end
  
  namespace :site do
    resources :user_requests, only: [:create]
  end
  get "site/user_requests/:token", to: 'site/user_requests#edit_request', as: "/edit_site_user_request/"
  post "site/user_requests/:token", to: 'site/user_requests#process_request'

  # post "requests/create_password"
  # get "reset_password/:token", to: 'requests#reset_password', as: 'reset_password'
  # post "update_password/:token", to: 'requests#update_password', as: 'update_password'
  # post "requests/create_join"
  # get "requests/confirm_join/:token", to: 'requests#confirm_join'
  # post "requests/update_join/:token", to: 'request#update_join'    
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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
