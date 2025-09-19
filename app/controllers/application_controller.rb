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

  # skip de autorización en Devise / ActiveStorage / health, y a definir.
  def skip_authorization?
    devise_controller? ||
      controller_path.start_with?("active_storage/") ||
      controller_path == "rails/health"
  end
end
