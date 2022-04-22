class Project < ApplicationRecord
  belongs_to :manager
  has_many :bugs
  has_and_belongs_to_many :developers, join_table: 'projects_developers'
  has_and_belongs_to_many :qas, join_table: 'projects_qas'
end
