class AddStatusToBugs < ActiveRecord::Migration[5.2]
  def change
    add_column :bugs, :status, :integer
  end
end
