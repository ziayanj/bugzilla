class CreateProjectsDevelopers < ActiveRecord::Migration[5.2]
  def change
    create_table :projects_developers, id: false do |t|
      t.belongs_to :project, index: true
      t.belongs_to :developer, index: true
    end
  end
end
