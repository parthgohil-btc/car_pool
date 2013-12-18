Routes::Application.routes.draw do

  root :to => 'routes#index'

  post 'car_pools/create', to: 'car_pools#create', as: 'create_car_pools'
  get '/car_pools/new', to: 'car_pools#new', as: 'new_car_pool'
  # get '/car_pools/index', to: 'car_pools#index', as: 'car_pools_index'
  get '/car_pools/search', to: 'car_pools#search', as: 'car_pools_search'
  get '/car_pools/search_car_pool', to: 'car_pools#search_car_pool', as: 'search_car_pools'
  get '/car_pools/:id/:school_id/:distance/join', to: 'car_pools#join', as: 'join_car_pool'
  post '/car_pools/:id/:school_id/:distance/join_car_pool', to: 'car_pools#join_car_pool', as: 'join'
  post '/car_pools/:id/:size/:school_id/:distance/leave_car_pool', to: 'car_pools#leave_car_pool', as: 'leave_car_pool'
  get '/car_pools/show_car_pools', to: 'car_pools#show_car_pools', as: 'show_car_pools'
  get '/car_pools/show_searched_car_pools', to: 'car_pools#show_searched_car_pools', as: 'show_searched_car_pools'
  get '/car_pools/:id/:school_id/:distance/:pre_action/show', to: 'car_pools#show', as: 'show_car_pool'
  resources :car_pools

  resources :schedules


  get '/schools/index', to: 'schools#index', as: 'schools_index'
  post '/schools/create', to: 'schools#create', as: 'create_school'

  get '/schools/new', to: 'schools#new', as: 'new_school'
  
  get '/students/index', to: 'students#index', as: 'students_index'
  post '/students/create', to: 'students#create', as: 'create_student'
  post '/students/new', to: 'students#new', as: 'new_student'
  post '/students/:id/update', to: 'students#update', as: 'update_student'
  post '/students/:id/delete', to: 'students#delete', as: 'delete_student'
  get "/students/show"
  resources :students

  get "/schools/show"
  get "/schools/search"
  post '/schools/:id/delete', to: 'schools#delete', as: 'delete_school'
  post '/schools/:id/update', to: 'schools#update', as: 'update_school'
  get "/schools/destroy"
  resources :schools

  get "/routes/search"
  get "/routes/new"
  get "/routes/create"
  
  devise_for :users do
    get "/sign_in", :to => "devise/sessions#new"
  end

  get '/home/new_profile', to: 'home#new_profile', as: 'new_profile'
  post '/home/create_profile', to: 'home#create_profile', as: 'create_profile'
  get '/home/new_address', to: 'home#new_address', as: 'new_address'
  post '/home/create_address', to: 'home#create_address', as: 'create_address'
  get '/home/edit_profile', to: 'home#edit_profile', as: 'edit_profile'
  post '/home/update_profile', to: 'home#update_profile', as: 'update_profile'
  get '/home/edit_address', to: 'home#edit_address', as: 'edit_address'
  post '/home/update_address', to: 'home#update_address', as: 'update_address'
  # get '/home/new_student', to: 'home#new_student', as: 'new_student'
  # post 'home/create_student', to: 'home#create_student', as: 'create_student'
  resources :home
  
  # root "home#index"
  # devise_for :users

  # root "routes#index"
  # get "/routes/show"
  # get "routes/search"
  
  # root 'users#index'

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
