Rails.application.routes.draw do
  
  
  scope "(:locale)" do
    root to: 'visitors#index'
    
    resources :transactions
    resources :connectors
    resources :boxes
    
    get 'connectors/:id/switch_on', to: 'connectors#switch_on', as: :switch_on_connector
    get 'connectors/:id/switch_off', to: 'connectors#switch_off', as: :switch_off_connector
    post 'connectors/:id/token', to: 'connectors#token'
    
    
    resources :socket_usages
    resources :socket_loads
    resources :el_sockets
    resources :tags
    get 'el_sockets/:id/switch_on', to: 'el_sockets#switch_on', as: :switch_on_el_socket
    get 'el_sockets/:id/switch_off', to: 'el_sockets#switch_off', as: :switch_off_el_socket
    devise_for :users, controllers: { registrations: "registrations" }
    get 'users/:id/menu', to: 'users#menu', as: :menu_user
    get 'users/:id/approve', to: 'users#approve', as: :approve_user
    get 'users/:id/disapprove', to: 'users#disapprove', as: :disapprove_user
    resources :users  

    #post
    post 'el_sockets/:id/rfid', to: 'el_sockets#rfid'
  end
  
  
end
