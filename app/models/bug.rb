class Bug < ApplicationRecord
  belongs_to :creator, class_name: "Qa", foreign_key: 'qa_id'
  belongs_to :developer, optional: true
  belongs_to :project
end
