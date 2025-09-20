
["Administrador", "Preceptor", "Docente", "Alumno"].each do |role_name|
  Role.find_or_create_by!(name: role_name)
end

puts "Roles creados: #{Role.pluck(:name).join(', ')}"


admin_email = "admin@admin.com"
admin_pass  = "admin8532"

admin = User.find_or_create_by!(email: admin_email) do |u|
  u.password = admin_pass
  u.password_confirmation = admin_pass
end

admin_role = Role.find_by!(name: "administrador")
admin.roles << admin_role unless admin.roles.include?(admin_role)

puts "Usuario admin creado: #{admin.email} con rol administrador"
