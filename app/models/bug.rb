class Bug < ApplicationRecord
  belongs_to :creator, class_name: "Qa"
  belongs_to :developer
  belongs_to :project
end
