require "test_helper"

class OptionTest < ActiveSupport::TestCase
  def test_validations
    question = questions(:algebra_question_1)

    option = question.options.build
    assert_not option.valid?

    option.name = "yes"
    assert option.valid?

    assert option.save

    # don't allow delete last correct answer
    question.options.where.not(id: option.id).update_all(is_correct: false)
    option.update! is_correct: true


    assert_not option.destroy
    assert option.errors[:is_correct].present?
  end
end
