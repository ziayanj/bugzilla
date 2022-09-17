class AddDatabaseValidations < ActiveRecord::Migration[5.2]
  def change
    change_column_null :bugs, :title, false
    change_column_null :bugs, :category, false
    change_column_null :bugs, :status, false
    change_column_null :projects, :title, false
  end
end
