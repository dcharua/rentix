Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "user/omniauth_callbacks", :registrations => "user/registrations" }
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#index'

  get "home/index"
  get "home/minor"
  get "search_all", to: "home#search"
  get 'pagos/:id/nuevo', to: "pagos#nuevo", as: "pagos_nuevo"
  get 'rentas/:id/terminar', to: "rentas#terminar", as: "rentas_terminar"
  get 'rentas/:id/borrar', to: "rentas#destroy", as: "rentas_borrar"


  resources :inquilinos
  resources :propiedads
  resources :rentas
  resources :pagos
  resources :gastos

  get 'search_inquilinos', to: "inquilinos#search", :defaults => { :format => 'js' }
  get 'search_propiedads', to: "propiedads#search", :defaults => { :format => 'js' }
  get 'search_rentas', to: "rentas#search", :defaults => { :format => 'js' }
  get 'search_pagos', to: "pagos#search", :defaults => { :format => 'js' }
  get 'crear_pagos', to: "pagos#crear", :defaults => { :format => 'js' }


  get 'existing_rentas', to: "rentas#existing", :defaults => { :format => 'js' }
  get 'nuevo_rentas', to: "rentas#nuevo", :defaults => { :format => 'js' }
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
