class Admin::QuestionsController < Admin::AdminController
  def index
    # @tests = Test.all
  end


  def new
    @test = Test.new
    option = Option.new is_correct: true
    @test.questions.build(options: [option])
  end

  def new_option
    @test = Test.new
    @option = Option.new
    @test.questions.build(options: [@option])
  end


  def destroy
    @test = Test.find(params[:test_id])
    @test.questions.find(params[:id]).destroy

    flash[:notice] = "Question deleted successfully."
    redirect_back fallback_location: admin_test_path(@test)
  end

  def destroy_option
    @test = Test.find(params[:test_id])
    @test.options.find(params[:id]).destroy

    redirect_back fallback_location: admin_test_path(@test)
  end

end
