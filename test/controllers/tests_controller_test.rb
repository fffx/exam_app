require "test_helper"

class TestsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users :student_tom
    @user.token || @user.regenerate_token

    @test = Test.take!
  end

  def test_lists
    get tests_path
    assert_response :unauthorized

    get tests_path, headers: {Authorization: @user.token}
    json_body => { tests: [{id: Integer, name: String, description: String | NilClass}, *]}
  end

  def test_show_test
    get test_path(@test)
    assert_response :unauthorized

    get test_path(@test), headers: {Authorization: @user.token}

    # puts json_body
    json_body => {
      id: Integer,
      name: String,
      description: String | NilClass,
      questions: [{
        id: Integer,
        name: String,
        description: String | NilClass,
        options: [String, *]
      }, *]
    }
  end


  def test_save_results
    post save_results_test_path(@test)
    assert_response :unauthorized

    post(
      save_results_test_path(@test),
      params: {answers: [{question_id: 1, answer_option_id: 2}]},
      headers: {Authorization: @user.token}
    )

    assert_response :success
  end

end
