Rails.application.routes.draw do
  get "carga-xlsx", to: "carga_xlsx#index"
  post "carga-xlsx/procesar", to: "carga_xlsx#procesar"
  resources :asistencia_generals
  resources :asistencia_materia
  resources :parametros
  resources :materia_alumnos
  resources :modulos
  resources :materia_docentes
  resources :divisions
  resources :materia
  resources :alumnos
  get "dashboard/index"
  resources :personas
  resources :docentes
  resources :perfils
  resources :orientacions
  resources :cursos
  resources :ciclo_lectivos
  resources :turnos
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
  root "dashboard#index"

end
