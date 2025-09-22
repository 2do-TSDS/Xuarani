
["Administrador", "Preceptor", "Docente", "Alumno"].each do |role_name|
  Role.find_or_create_by!(nombre: role_name)
end

puts "Roles creados: #{Role.pluck(:nombre).join(', ')}"


admin_email = "admin@admin.com"
admin_pass  = "admin8532"

admin = User.find_or_create_by!(email: admin_email) do |u|
  u.password = admin_pass
  u.password_confirmation = admin_pass
end

admin_role = Role.find_by!(nombre: "Administrador")
admin.roles << admin_role unless admin.roles.include?(admin_role)

puts "Usuario admin creado: #{admin.email} con rol administrador"
