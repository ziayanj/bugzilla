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
  enum category: { feature: 0, bug: 1 }
  enum status: { created: 0, started: 1, completed: 2, resolved: 3 }

  validates :title, title: true, on: :create
  validates :title, :deadline, :category, :status, presence: true
  validate :image_type, if: -> { screenshot.attached? }

  belongs_to :creator, class_name: 'Qa', foreign_key: 'qa_id'
  belongs_to :developer, optional: true
  belongs_to :project
  has_one_attached :screenshot

  private

  def image_type
    return if screenshot.content_type.in?(%w[image/png image/gif])

    screenshot.purge
    errors.add(:screenshot, 'Screenshot can only be either .png or .gif image')
  end
end
