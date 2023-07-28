# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# db/seeds.rb

# Array of categories
CATEGORIES = ["Food & Beverages", "Home & Decor", "Art"]

# Array of sample store names
STORE_NAMES = [
  "Tasty Treats",
  "Cozy Home",
  "Creative Corner",
  "Green Thumb",
  "Artistic Expressions",
  "Vintage Finds",
  "Sunny Days",
  "The Crafty Shop",
  "Healthy Bites",
  "Caffeine Fix"
]

# Array of real street names in Friedrichshain, Berlin
STREETS = [
  "Boxhagener Strasse",
  "Simon-Dach-Strasse",
  "Krossener Strasse",
  "Warschauer Strasse",
  "Frankfurter Allee",
  "Gruenberger Strasse",
  "Rigaer Strasse",
  "Revaler Strasse",
  "Grünberger Strasse",
  "Gabriel-Max-Strasse",
  "Wühlischstrasse"
]

# Method to create random opening times
def random_opening_times
  days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
  times = ["12:00-18:00", "10:00-20:00", "09:00-17:00", "11:00-19:00"]
  days.sample(5).map { |day| "#{day}: #{times.sample}" }.join(" & ")
end

# Method to generate random items
def generate_items(store)
  categories = CATEGORIES.sample(rand(1..CATEGORIES.length))
  rand(5..10).times do
    Item.create!(
      name: "Product #{rand(1000)}",
      price: rand(10..100),
      stock_quantity: rand(5..20),
      description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
      categories: categories,
      visible: true,
      store: store
    )
  end
end

# Seed stores
10.times do
  street = STREETS.sample
  street_number = rand(1..100)
  address = "#{street} #{street_number}, 10243 Berlin"
  Store.create!(
    name: STORE_NAMES.sample,
    address: address,
    opening_times: random_opening_times,
    description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
  )
end

# Seed items for each store
Store.all.each do |store|
  generate_items(store)
end
