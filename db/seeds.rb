# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'json'
require 'open-uri'

puts 'Cleaning DB!'

Ingredient.destroy_all

url = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list'
serialized = open(url).read
result = JSON.parse(serialized)

40.times do
  ingredient = result["drinks"].sample["strIngredient1"]
  Ingredient.create!(name: ingredient) unless Ingredient.find_by_name(ingredient)
end

puts "Seed done!"
