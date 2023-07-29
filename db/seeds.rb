# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# db/seeds.rb

# Array of categories
require 'faker'

# Seed data for stores
num_stores = 10
min_items_per_store = 5
max_items_per_store = 10

# Seed data for items
num_items = (num_stores * (min_items_per_store..max_items_per_store).to_a.sample).to_i

# Helper method to generate a random address within Friedrichshain, Berlin
def generate_address
  "#{Faker::Address.street_address}, Friedrichshain, Berlin"
end

# Create stores with items
stores = []
num_stores.times do
  store = Store.create!(
    name: Faker::Company.name,
    address: generate_address,
    opening_times: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now, format: :long),
    description: Faker::Lorem.paragraph
  )

  items_per_store = (min_items_per_store..max_items_per_store).to_a.sample
  items_per_store.times do
    store.items.create!(
      name: Faker::Commerce.product_name,
      price: Faker::Commerce.price(range: 1..100),
      stock_quantity: Faker::Number.between(from: 1, to: 100),
      description: Faker::Lorem.sentence,
      categories: Faker::Commerce.department(max: 3),
      visible: true
    )
  end

  stores << store
end

puts "Created #{num_stores} stores with #{num_items} items."
