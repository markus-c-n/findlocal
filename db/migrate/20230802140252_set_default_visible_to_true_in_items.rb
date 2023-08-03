class SetDefaultVisibleToTrueInItems < ActiveRecord::Migration[7.0]
  def change
    change_column :items, :visible, :boolean, default: true
  end
end
