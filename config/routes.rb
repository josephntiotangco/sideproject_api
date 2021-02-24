Rails.application.routes.draw do
  resources :vehicleassignments
  resources :vehicles
  resources :people
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace 'api' do
    namespace 'v1' do
      resources :drivers, only: [:index, :show, :update, :create]
      resources :people, only: [:index, :show, :update, :create]
      resources :vehicles, only: [:index, :show, :update, :create]
    end #v1
  end #api
end
