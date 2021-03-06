Rails.application.routes.draw do
  root 'diets#nosotros'
  get 'nosotros' => 'diets#nosotros' 
  get 'muestra_dieta' => 'diets#muestra_dieta'
  get 'muestra_ejercicio' => 'fitnesses#muestra_ejercicio'
  get 'diets/toggle_favorito' => 'diets#toggle_favorito', as: "toggle_favorito_diet"
  get 'diets/puntuacion' => 'diets#puntuacion', as: "puntuacion_diet"
  get 'fitnesses/puntuacion' => 'fitnesses#puntuacion', as: "puntuacion_fitness"
  get 'fitnesses/toggle_favorito' => 'fitnesses#toggle_favorito', as: "toggle_favorito_fitness"
  resources :diets
  resources :fitnesses
  resources :users
  resource :session, only: [:new, :create, :destroy]
  get '/login' => 'sessions#new', as: "login"
  get '/logout' => 'sessions#destroy', as: "logout"

  get 'muestra_dieta_favorito' => 'diets#muestra_dieta_favorito'
  get 'muestra_ejercicio_favorito' => 'fitnesses#muestra_ejercicio_favorito'
  
  get '/minus' => 'diets#minus'
  get '/plus' => 'diets#plus'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
