class Option < ApplicationRecord
  belongs_to :question
  scope :correct, -> { where(is_correct: true) }

  before_destroy :prevent_destroy_last_correct_option

  validates_presence_of :name
  validate :ensure_at_least_one_correct_option

  private

  def ensure_at_least_one_correct_option
    # prevent change to incorrect if this is the only correct one
    return unless is_correct_changed?
    return if is_correct

    return if question.options.any?(&:is_correct)

    errors.add :is_correct, "at least one correct option is required."
  end

  def prevent_destroy_last_correct_option
    if question.options.correct.count == 1 && is_correct
      errors.add :is_correct, "this is the only one correct option, can not be deleted."
      throw(:abort)
    end
  end
end
