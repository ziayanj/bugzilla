class CreateBugs < ActiveRecord::Migration[5.2]
  def change
    create_table :bugs do |t|
      t.string :title
      t.string :description
      t.belongs_to :qa, index: true
      t.belongs_to :developer, index: true
      t.belongs_to :project, index: true

      t.timestamps
    end
  end
end
