class Manager < User
  has_many :projects, dependent: :destroy
end
