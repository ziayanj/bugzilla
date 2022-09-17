class Bug < ApplicationRecord
  enum category: { feature: 0, bug: 1 }
  enum status: { created: 0, started: 1, completed: 2, resolved: 3 }

  # validates :title, title: true, on: :create
  validates :title, uniqueness: { scope: :project_id }
  validates :title, :deadline, :category, :status, presence: true
  validate :image_type, if: -> { screenshot.attached? }

  belongs_to :creator, class_name: 'Qa', foreign_key: 'qa_id', inverse_of: :bugs
  belongs_to :developer, optional: true
  belongs_to :project
  has_one_attached :screenshot

  def resolvable
    case category
    when 'feature'
      status != 'completed'
    when 'bug'
      status != 'resolved'
    end
  end

  private

  def image_type
    return if screenshot.content_type.in?(%w[image/png image/gif])

    screenshot.purge
    errors.add(:screenshot, 'can only be either .png or .gif image')
  end
end
