AssistantEcriture::Application.routes.draw do
  get "chapitres/new"
  resources :chapitres
  resources :scenes
  resources :anecdotes
  resources :personnes
  resources :relationships, only: [:create, :destroy]
  root to: 'static_pages#home', via: :get, as: 'root'
  match '/help', to: 'static_pages#help', via: :get, as: 'help'
  match '/newchapter', to: 'chapitres#new', via: :get, as: 'newchapter'
  match '/editchapter/:id', to: 'chapitres#edit', via: :get, as: 'editchapter'
  match '/chapters', to: 'chapitres#index', via: :get, as: 'chapters'
  match '/newscene/:id', to: 'scenes#new', via: :get, as: 'newscene'
  match '/editscene/:id', to: 'scenes#edit', via: :get, as: 'editscene'
  match '/createscene/:id', to: 'scenes#create', via: :post, as: 'createscene'
  match '/newanecdote/:id', to: 'anecdotes#new', via: :get, as: 'newanecdote'
  match '/editanecdote/:id', to: 'anecdotes#edit', via: :get, as: 'editanecdote'
  match '/createanecdote/:id', to: 'anecdotes#create', via: :post, as: 'createanecdote'
  match '/newpersonne', to: 'personnes#new', via: :get, as: 'newpersonne'
  match '/editpersonne/:id', to: 'personnes#edit', via: :get, as: 'editpersonne'
  match '/createpersonne/:id', to: 'personnes#create', via: :post, as: 'createpersonne'
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
