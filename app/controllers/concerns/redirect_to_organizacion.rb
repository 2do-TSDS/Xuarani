# app/controllers/concerns/redirect_to_organizacion.rb
module RedirectToOrganizacion
  extend ActiveSupport::Concern

  private

  def from_organizacion?
    request.referer.to_s.include?("/organizacion")
  end

  def redirect_back_to_organizacion(tab, message)
    redirect_to organizacion_path(anchor: tab), notice: message
  end
end
