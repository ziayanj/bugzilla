class ChangeDescriptionInBugs < ActiveRecord::Migration[5.2]
  def change
    change_column :bugs, :description, :text
  end
end
