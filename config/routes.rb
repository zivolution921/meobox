Rails.application.routes.draw do
  
  get 'items/index'

  get 'items/new'

  get 'items/show'

  resources :plans
  root 'pages#home'
  get '/about' => 'pages#about'

  resources :users do
    resources :registrations
    delete 'unsubscribe' => 'registrations#unsubscribe'
  end

  resources :plans

  get "/sign_in" => "sessions#new", as: :sign_in
  post "/sign_in" => "sessions#create"
  # get "/sign_out" => "sessions#destroy", as: :sign_out
  delete 'sign_out', to: 'sessions#destroy', as: 'sign_out'

  get "/sign_up" => "users#new", as: :sign_up
  post "/sign_up" => "users#create"

  get 'auth/:provider/callback', to: 'sessions#facebook'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
 

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