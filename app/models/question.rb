class Question < ApplicationRecord
  belongs_to :test, counter_cache: true
  has_many :options, dependent: :destroy

  accepts_nested_attributes_for :options, reject_if: :all_blank

  validates_presence_of :name
  validate :ensure_at_least_one_correct_option, on: :create

  def ensure_at_least_one_correct_option
    unless options.any?(&:is_correct)
      errors.add(:options, "at least one correct option is required")
    end
  end
end
