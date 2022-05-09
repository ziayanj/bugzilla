class Project < ApplicationRecord
  belongs_to :manager
  has_many :bugs
  has_and_belongs_to_many :developers, join_table: 'projects_developers'
  has_and_belongs_to_many :qas, join_table: 'projects_qas'

  validates :title, presence: true
  validates :title, uniqueness: true

  def addable_users(current_user)
    final_users = []

    User.all.each do |user|
      if user == current_user
        next
      elsif user.type == 'Developer'
        final_users.append(user) unless self.developers.include? user
      elsif user.type == 'Qa'
        final_users.append(user) unless self.qas.include? user
      end
    end
    final_users
  end

  def removable_users(current_user)
    final_users = []

    User.all.each do |user|
      if user == current_user
        next
      elsif user.type == 'Developer'
        final_users.append(user) if self.developers.include? user
      elsif user.type == 'Qa'
        final_users.append(user) if self.qas.include? user
      end
    end
    final_users
  end
end
