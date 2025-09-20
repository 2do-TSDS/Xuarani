class Ability
    include CanCan::Ability

    def initialize(user)
        user ||= User.new

        return administrador_rules if user.has_role?(:administrador)
        preceptor_roles if user.has_role?(:preceptor)
        docente_rules if user.has_role?(:docente)
        alumno_rules if user.has_role?(:alumno)

        # Roles creados a futuro solo lectura de recursos públicos (sin Model)
        guest_rules if user.roles.empty?

    end

    def administrador_rules
        can :manage, :all
    end

    def preceptor_roles
        can :read, :all
    end

    def docente_rules
        can :read, :all
    end

    def alumno_rules
        can :read, :all
    end

    def guest_rules
        can :read, :publico
    end
end