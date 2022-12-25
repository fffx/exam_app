class Admin::OptionsController < Admin::AdminController
  def new
    @test = Test.new
    @option = Option.new
    @test.questions.build(options: [@option])
  end


  def destroy
    @test = Test.find(params[:test_id])
    option = @test.options.find(params[:id])
    if option.destroy
      flash[:notice] = "Option deleted successfully."
    else
      flash[:notice] = option.errors.first.message
    end
    redirect_back fallback_location: admin_test_path(@test)
  end

end
