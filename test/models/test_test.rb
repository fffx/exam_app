require "test_helper"

class TestTest < ActiveSupport::TestCase

  def test_validations
    test = Test.new
    assert_not test.valid?

    test.name = "Abstract Algebra 1"
    assert test.valid?
  end
end
