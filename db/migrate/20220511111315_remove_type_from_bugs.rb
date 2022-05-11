class RemoveTypeFromBugs < ActiveRecord::Migration[5.2]
  def change
    remove_column :bugs, :type, :integer
  end
end
