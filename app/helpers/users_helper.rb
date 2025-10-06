module UsersHelper
  def role_badge_class(role_name)
    case role_name.to_s.downcase
    when "administrador" then "bg-danger"
    when "docente"       then "bg-primary"
    when "preceptor"     then "bg-success"
    when "alumno"        then "bg-warning text-dark"
    else "bg-secondary"
    end
  end
end
