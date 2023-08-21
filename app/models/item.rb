class Item < ApplicationRecord
  belongs_to :store

  CATEGORIES = ["Fair trade", "Organic", "Sale", "New", "Drinks", "Gluten Free", "Alcohol", "Accessoires", "Furniture", "Decoration"]
end
