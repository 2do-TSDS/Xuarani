class ApplicationController < ActionController::Base
  allow_browser versions: :modern
  before_action :authenticate_user!
  check_authorization unless: :skip_authorization?

  rescue_from CanCan::AccessDenied do |e|
    respond_to do |format|
      format.html { redirect_to root_path, alert: e.message }
      format.json { render json: { error: "Forbidden" }, status: :forbidden }
    end
  end

  private

  # Devise: ¿a dónde va el usuario después de iniciar sesión?
  def after_sign_in_path_for(user)
    # Si Devise tenía guardado un destino (por ejemplo, al intentar entrar a una página protegida),
    # respetalo primero para no romper flujos.
    stored = stored_location_for(user)
    return stored if stored.present?

    # Redirecciones por rol
    return docente_dashboard_path            if user.has_role?(:docente)
    return users_path                        if user.has_role?(:administrador) # o tu panel admin si lo tenés (admin_dashboard_path)
    return organizacion_path                 if user.has_role?(:preceptor)     # ajustá a tu ruta real
    return root_path                         if user.has_role?(:alumno)

    # Fallback genérico
    root_path
  end

  # Devise: ¿a dónde va después de cerrar sesión? (opcional)
  def after_sign_out_path_for(_scope)
    root_path
  end

  # skip de autorización en Devise / ActiveStorage / health, y a definir.
  def skip_authorization?
    devise_controller? ||
      controller_path.start_with?("active_storage/") ||
      controller_path == "rails/health"
  end
end
