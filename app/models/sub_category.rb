class SubCategory < ApplicationRecord
  belongs_to :main_category, class_name: 'MainCategory', foreign_key: :parent_id


end
