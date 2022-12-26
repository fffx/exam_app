require "test_helper"

class QuestionTest < ActiveSupport::TestCase
  def test_validations
    @test = Test.create(name: "algebra")
    question = @test.questions.build
    assert_not question.valid?

    question.name = "Is the polynomial x^4 + X^3 + 1 reduciable?"
    assert_not question.valid?

    question.options.build(name: "Yes", is_correct: false)
    assert_not question.valid?

    question.options.build(name: "no", is_correct: true)

    assert question.valid?
    assert question.save
  end
end
