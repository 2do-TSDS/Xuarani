Rails.application.routes.draw do
  get "organizacion/index"
  resources :users
  resources :asistencia_materias
  resources :asistencia_generals
  resources :modulos
  resources :materia_alumnos
  resources :materia_docentes
  resources :materia_divisions do
    collection do
      get :materias_disponibles
    end
  end
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
  devise_for :users, path: 'auth', path_names: { sign_in: 'login', sign_out: 'logout', password: 'secret' }
  get "organizacion", to: "organizacion#index"
  get "materias_panel", to: "materias_panel#index"

  root "dashboard#index"

  authenticate :user do
    get "docente", to: "docente/dashboard#index", as: :docente_dashboard
  end
  
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check


end
