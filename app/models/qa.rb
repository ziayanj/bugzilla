class Qa < User
  has_many :bugs, dependent: :destroy, inverse_of: :creator
  has_and_belongs_to_many :projects, join_table: 'projects_qas'
end
