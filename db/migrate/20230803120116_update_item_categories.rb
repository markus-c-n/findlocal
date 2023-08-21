class UpdateItemCategories < ActiveRecord::Migration[7.0]
  def up
    change_column :items, :categories, :string, array: true, default: [], using: "(string_to_array(categories, ','))"
  end

  def down
    change_column :items, :categories, :string, array: false, default: nil
  end
end
