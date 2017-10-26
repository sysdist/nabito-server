Rails.application.routes.draw do
  
  scope "(:locale)" do
    root to: 'visitors#index'
    
    resources :socket_usages
    resources :socket_loads
    resources :el_sockets
    resources :tags
    get 'el_sockets/:id/switch_on', to: 'el_sockets#switch_on', as: :switch_on_el_socket
    get 'el_sockets/:id/switch_off', to: 'el_sockets#switch_off', as: :switch_off_el_socket
    devise_for :users
    get 'users/:id/menu', to: 'users#menu', as: :menu_user
    get 'users/:id/approve', to: 'users#approve', as: :approve_user
    get 'users/:id/disapprove', to: 'users#disapprove', as: :disapprove_user
    resources :users  
  end
  
end
