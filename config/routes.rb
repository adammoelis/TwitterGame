Rails.application.routes.draw do
  get 'home/index'
  post 'home/index', to: "home#update_score"
  post '/', to: "home#update_score"
  post 'home', to: "home#set_default"
  patch 'home/add', to: "home#new"
  get 'home/new'
  patch 'home/update'
  get 'home/update'
  patch 'home/remove', to: "users#remove"
  get '/auth/:provider/callback', to: 'sessions#create'
  post '/logout', to: "sessions#logout"
  get '/game', to: "home#custom"
  post '/game', to: "home#add_to_custom"
  patch '/game', to: "home#update_custom_score"
  delete '/game', to: "home#remove_from_custom"


  resources :users
  resources :tweets

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
