class AsistenciaMateria < ApplicationRecord
  belongs_to :materia_alumno
  belongs_to :parametro

  has_one :materia_division, through: :materia_alumno
  has_one :alumno, through: :materia_alumno, source: :alumno

  validates :materia_alumno, :parametro, :fecha, presence: true
  validates :modulo, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  validates :modulo, uniqueness: {
    scope: [:materia_alumno_id, :fecha],
    message: "La asistencia ya ha sido registrada para este dia"
  }

  validate :modulo_correlativo_en_el_dia
  validate :modulo_no_supera_cantidad_definida

  private
  def dia_cw
    return nil if fecha.blank?
    fecha.cwday # 1..7
  end

  def modulo_correlativo_en_el_dia
    return if errors.any? || fecha.blank? || materia_alumno_id.blank?

    max_existente = self.class.where(materia_alumno_id: materia_alumno_id, fecha: fecha)
                              .maximum(:modulo)
    esperado = (max_existente || 0) + 1

    if modulo != esperado
      errors.add(:modulo, "El Módulo debe ser correlativo a: #{max_existente} para ese día")
    end
  end


  def modulo_no_supera_cantidad_definida
    return if errors.any? || modulo.blank? || materia_division.blank?

    dia = dia_cw
    if dia.nil?
      errors.add(:base, "No se pudo determinar el día (1..7) desde la fecha")
      return
    end

    conf = Modulo.find_by(materia_division_id: materia_division.id, dia: dia)
    if conf.nil?
      errors.add(:base, "No hay módulos definidos para el día #{dia} en esta materia")
      return
    end

    if modulo > conf.cantidad
      errors.add(:modulo, "La cantidad de módulos no puede ser mayor que #{conf.cantidad} para el día #{dia}")
    end
  end
end
