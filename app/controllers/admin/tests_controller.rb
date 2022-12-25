class Admin::TestsController < Admin::AdminController
  before_action :load_test, only: [:destroy, :edit, :update, :show]

  def index
    @tests = Test.all
  end

  def new
    @test = Test.new
    option = Option.new is_correct: true
    @test.questions.build(options: [option])
  end

  def edit

  end

  def create
    test = Test.new(params[:test].permit(:name, :description))
    questions = []

    params[:test][:questions_attributes].each do |_, question_params|
      question = test.questions.build(
        question_params.permit(
          :name, :description,
          options_attributes: [:name, :is_correct]
        )
      )

      questions << question

    end

    test.save!
    redirect_to admin_tests_path, notice: "Test created successfully"
  end

  def update
    if @test.update(params[:test].permit(
        :name, :description,
        questions_attributes: [
          :name, :id, :description,
          {options_attributes: [:id, :name, :is_correct]}
        ]
      ))
      redirect_to admin_tests_path, notice: "Test updated successfully"
    else
      # byebug
      redirect_to edit_admin_test_path(@test), notice: @test.errors.full_messages.join("; ")
    end
  end

  def destroy
    @test.destroy
    redirect_to admin_tests_path, notice: "Delete successfully"
  end

  private

  def load_test
    @test = Test.find(params[:id])
  end

end
