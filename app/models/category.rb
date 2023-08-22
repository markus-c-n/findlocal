class Category < ApplicationRecord
  has_many :main_categories, class_name: 'Category', foreign_key: :parent_id
  belongs_to :parent, class_name: 'Category', optional: true

end
