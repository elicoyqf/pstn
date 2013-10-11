Pstn::Application.routes.draw do

  get "gpon/preconfig"
  post "gpon/g_command"

  get 'pass_modify/modify'
  post 'pass_modify/m_submit'

  resources :events do
    collection do
      get 'query'
      get 'q_submit'
    end
  end

  get '/events/query'
  match '/calendar(/:year(/:month))' => 'calendar#index', :as => :calendar, :constraints => { :year => /\d{4}/, :month => /\d{1,2}/ }
  match '/logout',to:'welcome#logout'
  get 'log_book/logging'

  match 'log_book/type/:type' => 'log_book#log_type'
  get 'log_book/switch'
  post 'log_book/log_submit'
  get 'business_logic/change'
  post 'business_logic/bl_submit'

  get 'query_data/stop'
  get 'query_data/start'
  match 'query_data/mdf_status/:id' => 'query_data#mdf_status'

  get 'query_data/m_status'
  get 'query_data/m_cfd'
  get 'query_data/p_m_cfd'
  get 'query_data/status'
  get 'welcome/index'
  get 'query_data/q_cont_data'

  post 'welcome/pstn_stop'
  post 'welcome/pstn_badp'
  post 'welcome/pstn_deni'
  post 'welcome/pstn_reset'
  post 'welcome/i_pstn_stop'
  post 'welcome/i_pstn_badp'
  post 'welcome/i_pstn_deni'
  post 'welcome/i_pstn_reset'

  post 'welcome/reverse_pstn_stop'
  post 'welcome/reverse_pstn_badp'
  post 'welcome/reverse_pstn_deni'
  post 'welcome/i_reverse_pstn_stop'
  post 'welcome/i_reverse_pstn_badp'
  post 'welcome/i_reverse_pstn_deni'

  post 'welcome/main'
  get 'welcome/p_stop'
  get 'welcome/p_start'

  root :to => 'welcome#index'
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
