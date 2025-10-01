class DashboardController < ApplicationController
  before_action :authenticate_user!
  skip_authorization_check

  def index
    if current_user.has_role?(:administrador)
      render "dashboard/index"
    elsif current_user.has_role?(:docente)
      render "docente/dashboard/index"
    elsif current_user.has_role?(:preceptor)
      render "dashboard/preceptor"
    else
      render "dashboard/alumno"
    end
  end
end
