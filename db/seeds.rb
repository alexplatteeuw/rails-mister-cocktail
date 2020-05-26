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

Dose.destroy_all
Ingredient.destroy_all
Cocktail.destroy_all

puts 'Seed Doses'

15.times do
  url = 'https://www.thecocktaildb.com/api/json/v1/1/random.php'
  serialized = open(url).read
  result = JSON.parse(serialized)

  cocktail_name = result["drinks"].first["strDrink"]

  cocktail = Cocktail.create!(name: cocktail_name) unless Cocktail.find_by_name(cocktail_name)

  5.times do
    url = 'https://www.thecocktaildb.com/api/json/v1/1/random.php'
    serialized = open(url).read
    result = JSON.parse(serialized)

    ingredient_name = result["drinks"].first["strIngredient1"]
    dose_description = result["drinks"].first["strMeasure1"]

    ingredient = Ingredient.create!(name: ingredient_name) unless Ingredient.find_by_name(ingredient_name)

    dose = Dose.new(description: dose_description) if dose_description

    p dose.cocktail = cocktail if dose
    dose.ingredient = ingredient if dose

    dose.save! if cocktail && ingredient && dose
  end
end

puts "Seed done!"
