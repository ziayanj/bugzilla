class Qa < User
  has_many :bugs
  has_and_belongs_to_many :projects, join_table: 'projects_qas'
end
