require "test_helper"

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def test_role_validation
    user = users(:teacher_john)

    user.role = 'admin'
    assert_not user.valid?

    user.role = 'student'
    assert user.valid?

    user.role = 'teacher'
    assert user.valid?

    assert user.save
  end

  def test_email_validation
    john = users(:teacher_john)
    tom = users(:student_tom)

    assert tom.valid?
    assert john.valid?

    tom.email = john.email
    assert_not tom.valid?

    john.email = nil
    assert_not john.valid?

    john.email = 'john.com'
    assert_not john.valid?

    john.reload

    assert john.valid?

  end

end
