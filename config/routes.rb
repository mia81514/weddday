Rails.application.routes.draw do
  mount Bootsy::Engine => '/bootsy', as: 'bootsy'
  get 'hello_world', to: 'hello_world#index'
  devise_for :users, :skip => [:sessions,:registrations],
             :controllers => {
               :sessions => "custom_sessions",
               :registrations => "registrations",
               :omniauth_callbacks => "omniauth_callbacks"
             }

  devise_scope :user do
    get  'sign_in'   ,:to => 'devise/sessions#new'         ,:as => :new_user_session
    post '/sign_up'  ,:to => 'devise/registrations#new'    ,:as => :new_user_registration
  end

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
  match "/api/sign_in"  => "api/base#do_sign_in", :via => :post
  match "/api/sign_out" => "api/base#do_sign_out"  , :via => :all
  namespace :api do
    resources :hosts do
      collection do
        match '/:action', :via => :all
        match '/event/:event_id'                      => 'hosts#event'                , :via => [:get, :post]
        #桌次
        match '/event/:event_id/table_arranges'       => 'hosts#table_arranges'       , :via => [:get, :post]
        match '/event/:event_id/table_arrange/:ta_id' => 'hosts#table_arranges'       , :via => [:get, :post]
        match '/event/:event_id/table_arrange/create' => 'hosts#create_table_arrange' , :via => [:post]
        #問卷
        match '/event/:event_id/questionnaires'       => 'hosts#questionnaires'       , :via => [:get, :post]
        match '/event/:event_id/questionnaire/create' => 'hosts#create_questionnaire' , :via => [:post]
      end
    end
  end
  match ':controller(/:action(/:id(.:format)))', :via => :all
  root :to => 'home#index'
end
