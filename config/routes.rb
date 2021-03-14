Rails.application.routes.draw do
 
  devise_for :endusers
  
  #use_doorkeeper

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  use_doorkeeper do
    #skip_controllers :endusers, only: [:index, :create]
    # No need to register client application
    #skip_controllers :applications, :authorized_applications
  end

  namespace 'api' do
    namespace 'v1' do
      #enduser
      #resources :endusers, :path => "endusers/list", only: [:index, :show]
      #resources :endusers, :path => "endusers/update", only: [:update]
      #resources :endusers, :path => "endusers/register", only: [:create]
      #resources :endusers, :path => "endusers/delete", only: [:destroy]
      resources :endusers, only: [:index, :show, :update, :create]
      resources :vehicles, only: [:index, :show, :update, :create]
      #resources :users, only: [:index, :show]
      resources :roles
    end #api
  end #v1
end
