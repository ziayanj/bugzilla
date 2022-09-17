class Developer < User
  has_many :bugs, dependent: :nullify
  has_and_belongs_to_many :projects, join_table: 'projects_developers'
end
