class AddForeignKeyConstraints < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :bugs, :users, column: :developer_id
    add_foreign_key :bugs, :users, column: :qa_id
    add_foreign_key :bugs, :projects
    add_foreign_key :projects, :users, column: :manager_id
    add_foreign_key :projects_developers, :projects
    add_foreign_key :projects_developers, :users, column: :developer_id
    add_foreign_key :projects_qas, :projects
    add_foreign_key :projects_qas, :users, column: :qa_id
    
  end
end
