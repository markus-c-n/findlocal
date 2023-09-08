class Item < ApplicationRecord
  has_one_attached :photo
  belongs_to :store
  belongs_to :main_category, class_name: 'Category', optional: true
  belongs_to :sub_category, class_name: 'Category', optional: true

  validate :sub_category_belongs_to_main_category
  def sub_category_belongs_to_main_category
    return if main_category.blank? || sub_category.blank?
    errors.add(:sub_category, "must belong to the selected main category") unless sub_category.main_category == main_category
  end
end
