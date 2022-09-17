class Project < ApplicationRecord
  belongs_to :manager
  has_many :bugs, dependent: :destroy
  has_and_belongs_to_many :developers, join_table: 'projects_developers'
  has_and_belongs_to_many :qas, join_table: 'projects_qas'

  validates :title, presence: true
  validates :title, uniqueness: { case_sensitive: false }

  def addable_users(current_user)
    final_users = []

    User.find_each do |user|
      if user == current_user
        nil
      elsif user.type == 'Developer'
        final_users.append(user) unless developers.include? user
      elsif user.type == 'Qa'
        final_users.append(user) unless qas.include? user
      end
    end
    final_users
  end

  def removable_users
    final_users = []

    User.find_each do |user|
      final_users.append(user) if (developers.include? user) || (qas.include? user)
    end
    final_users
  end
end
