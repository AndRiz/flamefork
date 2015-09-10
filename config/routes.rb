PoliRun::Application.routes.draw do

  # event for the homepage
  root to: 'pages#home'

  # named events for static pages
  match '/about', to: 'pages#about'
  match '/contact', to: 'pages#contact'
  match '/faq', to: 'pages#faq'

  match '/signup', to: 'users#new'

  match '/signin', to: 'sessions#new'
  # signout should be performed by using the HTTP DELETE request
  match '/signout', to: 'sessions#destroy', via: :delete

  # events for the Users controller (default plus following and followers)
  resources :users do
    member do
      get :following, :followers, :receiving, :senders, :myevents # ex.: get /users/1/followers
    end
    resources :events, only: [:new, :create, :destroy, :show, :index] # ex.: get /users/1/events/1
  end

  # default events for the Relationship controller (only create and destroy) - needed to build follow/unfollow relations
  resources :relationships, only: [:create, :destroy]


  # events for the Events controller (default plus participating and participants)
  resources :events do
    member do
      get :participating, :participants  # ex.: get /users/1/followers
    end
    resources :events, only: [:new, :create, :destroy, :show, :index] # ex.: get /users/1/events/1
  end


  resources :mails do
   member do
     # get :sents, :receiveds        # ex.: get /users/1/followers
    end
    resources :events, only: [:new, :create, :destroy, :show, :index] # ex.: get /users/1/events/1
  end

  # default events for the Relationship controller (only create and destroy) - needed to build follow/unfollow relations
  resources :relationships, only: [:create, :destroy]



  # default events for the Participations controller (only create and destroy) - needed to build partipate/unparticipate relations
  resources :participations, only: [:create, :destroy]


  # events for the mails controller


 # resources :mails do
  #  resources :mails, only: [:new, :create, :destroy, :show, :index] # ex.: get /users/1/events/1
 # end



  # default events for the Sessions controller (only new, create and destroy)
  resources :sessions, only: [:new, :create, :destroy]

  # default events for the Posts controller (only create and destroy - other operations will be done via the Users controller)
  resources :posts, only: [:create, :destroy]

  # default events for the Comments controller (only create and destroy - other operations will be done via the Users controller)
  resources :comments, only: [:create, :destroy]



  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular event:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named event:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This event can be invoked with purchase_url(:id => product.id)

  # Sample resource event (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource event with options:
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

  # Sample resource event with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource event with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource event within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your events lay out with "rake events"

  # This is a legacy wild controller event that's not recommended for RESTful applications.
  # Note: This event will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
