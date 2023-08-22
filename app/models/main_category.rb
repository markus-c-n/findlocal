class MainCategory < ApplicationRecord
  has_many :sub_categories, class_name: 'Category', foreign_key: :parent_id

end
