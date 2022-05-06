class TitleValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    valid = true

    record.project.bugs.each do |bug|
      valid = false if bug.title.downcase == value.downcase
    end
    record.errors[attribute] << "Project already contains a bug with this #{attribute}" unless valid
  end
end

class Bug < ApplicationRecord
  validates :title, title: true

  belongs_to :creator, class_name: "Qa", foreign_key: 'qa_id'
  belongs_to :developer, optional: true
  belongs_to :project
end
