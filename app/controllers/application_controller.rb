class ApplicationController < ActionController::Base
  # Obliga a navegadores modernos
  allow_browser versions: :modern

  # Requiere que el usuario esté autenticado en todas las acciones
  before_action :authenticate_user!

  # Evita que el navegador guarde en caché páginas sensibles
  before_action :set_cache_buster

  # Fuerza autorización con CanCanCan
  check_authorization unless: :skip_authorization?

  # Manejo de errores de autorización
  rescue_from CanCan::AccessDenied do |e|
    respond_to do |format|
      format.html { redirect_to root_path, alert: e.message }
      format.json { render json: { error: "Forbidden" }, status: :forbidden }
    end
  end

  # Define a dónde va el usuario después de iniciar sesión
  def after_sign_in_path_for(user)
    stored = stored_location_for(user)
    return stored if stored.present?

    # Redirecciones según rol
    if user.has_role?(:administrador)
      admin_dashboard_path   # NUEVO: ruta clara para admin
    elsif user.has_role?(:docente)
      docente_dashboard_path # YA EXISTÍA
    elsif user.has_role?(:preceptor)
      organizacion_path      # YA EXISTÍA
    elsif user.has_role?(:alumno)
      public_home_path       # NUEVO: ruta genérica para alumnos/público
    else
      root_path              # Fallback
    end
  end

  # Define a dónde va después de cerrar sesión
  def after_sign_out_path_for(_scope)
    root_path
  end

  private

  # Excepciones para no exigir autorización
  def skip_authorization?
    devise_controller? ||
      controller_path.start_with?("active_storage/") ||
      controller_path == "rails/health"
  end

  # Evita que al usar "Atrás" se vean páginas cacheadas
  def set_cache_buster
    response.headers["Cache-Control"] = "no-store, no-cache, must-revalidate, max-age=0"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end
end
