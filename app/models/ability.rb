class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    return administrador_rules if user.has_role?(:administrador)
    return preceptor_roles     if user.has_role?(:preceptor)
    return docente_rules(user) if user.has_role?(:docente)
    return alumno_rules        if user.has_role?(:alumno)

    guest_rules
  end

  def administrador_rules
    can :manage, :all
  end

  def preceptor_roles
    can :read, :all
  end

  def docente_rules(user)
    can :read, :docente_dashboard

    # Puede ver solo las divisiones/materias que le correspondan
    can :read, MateriaDivision, materia_docentes: { docente_id: user.id }

    # ❌ ANTES: usabas una asociación que no existe en Materia
    # can :read, Materia, materia_divisiones: { materia_docentes: { docente_id: user.id } }

    # ✅ NUEVO: acceso a materias a través de MateriaDivision
    can :read, Materia, id: MateriaDivision
                           .joins(:materia_docentes)
                           .where(materia_docentes: { docente_id: user.id })
                           .select(:materia_id)

    # Puede ver alumnos solo dentro de sus materias/divisiones
    can :read, MateriaAlumno, materia_division: { materia_docentes: { docente_id: user.id } }

    # Puede gestionar asistencias solo de sus propios alumnos
    can :manage, AsistenciaMateria,
        materia_alumno: { materia_division: { materia_docentes: { docente_id: user.id } } }
  end

  def alumno_rules
    can :read, :all
  end

  def guest_rules
    can :read, :publico
  end
end
