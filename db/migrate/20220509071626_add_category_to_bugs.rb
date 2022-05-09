class AddCategoryToBugs < ActiveRecord::Migration[5.2]
  def change
    add_column :bugs, :category, :integer
  end
end
