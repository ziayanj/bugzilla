class CreateProjectsQas < ActiveRecord::Migration[5.2]
  def change
    create_table :projects_qas, id: false do |t|
      t.belongs_to :project, index: true
      t.belongs_to :qa, index: true
    end
  end
end
