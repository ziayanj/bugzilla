class Project < ApplicationRecord
  belongs_to :manager
  has_many :bugs
end
