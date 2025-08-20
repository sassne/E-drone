Rails.application.routes.draw do
  devise_for :users

  authenticate :user do
    root "dashboard#index"
    get "dashboard", to: "dashboard#index"

    resources :drones
    resources :voles do
      member do
        patch :land
        post :add_observation
        get :export_pdf
        get :export_excel
        get :export_observations_pdf
      end
      resources :observations, only: [ :index, :new, :create ]
    end
  end

  namespace :admin do
    resources :users do
      collection do
        get :export_excel
        get :export_pdf
      end
    end
    resources :drones do
      collection do
        get :export_excel
        get :export_pdf
      end
    end
    resources :voles do
      collection do
        get :export_excel
        get :export_pdf
      end
    end
    resources :observations do
      collection do
        get :export_excel
        get :export_pdf
      end
    end
    get "dashboard", to: "dashboard#index"
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
