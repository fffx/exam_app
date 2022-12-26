class TestsController < ApplicationController

  # list tests
  def index
    render json: {tests: test.all}
  end

  # show test by id

  # @return
  #  {
  #     name: 'test name',
  #     description: 'test description',
  #     question: [
  #       name: 'question name',
  #       description: 'question description'
  #     ]
  #   }
  def show
    test = Test.find(params[:id])
    render json: {
      name: test.name,
      description: test.description,
      questions: test.questions.map do |q|
        {
          name: q.name,
          description: q.description,
        }
      end
    }
  end

  # Save test results
  # @id
  # @questions [question_id: answer_option_id]

  # return success if successful
  def save_results
    render json: {status: 'success'}, status: :ok
  end
end
