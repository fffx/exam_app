class User < ApplicationRecord
  ROLES = ['student', 'teacher'].freeze

  has_secure_password
  validates :role, presence: true, inclusion: { in: User::ROLES,
           message: "must be a student or teacher" }

  scope :teachers, -> { where(role: :teacher) }
  scope :students, -> { where(role: :student) }

  before_create do
    self.name = email.split('@')[0] if self.name.blank?
  end

end
