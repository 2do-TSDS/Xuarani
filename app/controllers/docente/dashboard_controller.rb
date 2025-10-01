# app/controllers/docente/dashboard_controller.rb
module Docente
  class DashboardController < ApplicationController
    before_action :authenticate_user!
    before_action -> { authorize! :read, :docente_dashboard }  # <- aquí se cumple check_authorization

    def index
      @materias_de_docente = MateriaDivision
        .joins(:materia_docentes)
        .where(materia_docentes: { docente_id: current_user.id })
        .includes(:division, materia: [:curso, :ciclo_lectivo])
        .order(Arel.sql("`ciclo_lectivos`.`año` ASC, `cursos`.`nombre` ASC, `materias`.`nombre` ASC, `divisions`.`nombre` ASC"))
        .distinct
        .load_async
    end
  end
end
