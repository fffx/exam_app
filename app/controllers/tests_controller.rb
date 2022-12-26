class TestsController < ApplicationController

  # list tests
  def index
    render json: {tests: Test.all}
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
      id: test.id,
      name: test.name,
      description: test.description,
      questions: test.questions.map do |q|
        {
          id: q.id,
          name: q.name,
          description: q.description,
          options: q.options.pluck(:name)
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
