class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.string :name
      t.integer :price
      t.integer :stock_quantity
      t.text :description
      t.string :categories
      t.string :pictures
      t.boolean :visible
      t.references :store, null: false, foreign_key: true

      t.timestamps
    end
  end
end
