Rails.application.routes.draw do
  resources :asistencia_materias
  resources :asistencia_generals
  resources :modulos
  resources :materia_alumnos
  resources :materia_docentes
  resources :materia_divisions
  resources :materias
  resources :turnos
  resources :orientacions
  resources :divisions
  resources :cursos
  resources :ciclo_lectivos
  resources :parametros
  resources :perfils
  resources :user_roles
  resources :roles
  devise_for :users
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
