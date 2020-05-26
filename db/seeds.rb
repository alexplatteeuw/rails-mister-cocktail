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

pictures = [
  "https://res.cloudinary.com/alexplatteeuw/image/upload/v1590496632/3jt3n007q7knkkbqscw8hcsacobw.jpg",
  "https://res.cloudinary.com/alexplatteeuw/image/upload/v1590496597/vn16rracqb1oj3dujmytcdg8ge1c.jpg",
  "https://res.cloudinary.com/alexplatteeuw/image/upload/v1590483649/toblqv67y6haketios4lybri0dz1.jpg",
  "https://res.cloudinary.com/alexplatteeuw/image/upload/v1590483563/4zy78qhkob2t6eora1tm0goueax4.jpg",
  "https://res.cloudinary.com/alexplatteeuw/image/upload/v1590483518/haw4isfaw6a8w7sbt6d7eaa9ou2y.jpg",
  "https://res.cloudinary.com/alexplatteeuw/image/upload/v1590483444/b2h9cxu43kevymzmwwz8oa1ggoth.jpg",
  "https://res.cloudinary.com/alexplatteeuw/image/upload/v1590483384/8koiicfb9sn53utu2r5hsaxgcdjq.jpg",
  "https://res.cloudinary.com/alexplatteeuw/image/upload/v1590481080/z2u2m72kxs1pl1vhhp7cikmln69w.jpg",
  "https://res.cloudinary.com/alexplatteeuw/image/upload/v1590480916/t4y4t5om10q525x1b2dc1tn2mydy.jpg"
]

15.times do
  url = 'https://www.thecocktaildb.com/api/json/v1/1/random.php'
  serialized = open(url).read
  result = JSON.parse(serialized)

  cocktail_name = result["drinks"].first["strDrink"]

  cocktail = Cocktail.new(name: cocktail_name) unless Cocktail.find_by_name(cocktail_name)

  file = URI.open(pictures.sample)
  cocktail.photo.attach(io: file, filename: 'nes.png', content_type: 'image/png')

  p cocktail.photo.attached?

  cocktail.save!

  cocktail = Cocktail.last

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
