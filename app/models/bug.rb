class Bug < ApplicationRecord
  belongs_to :creator, class_name: "Qa", optional: true
  belongs_to :developer, optional: true
  belongs_to :project
end
