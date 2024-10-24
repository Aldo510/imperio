# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# db/seeds.rb

# Crear categorías
# db/seeds.rb

# Crear categorías
category1 = Category.create(name: "Categoría A")
category2 = Category.create(name: "Categoría B")
category3 = Category.create(name: "Categoría C")

# Equipos para la Categoría A
(1..18).each do |i|
  Team.create(name: "Equipo A#{i}", category: category1)
end

# Equipos para la Categoría B
(1..18).each do |i|
  Team.create(name: "Equipo B#{i}", category: category2)
end

# Equipos para la Categoría C
(1..18).each do |i|
  Team.create(name: "Equipo C#{i}", category: category3)
end

puts "Se han creado las categorías y equipos correctamente"


puts "Seeded #{Category.count} categories and #{Team.count} teams"
