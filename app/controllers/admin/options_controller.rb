class Admin::OptionsController < Admin::AdminController
  def new
    @test = Test.new
    @option = Option.new
    @test.questions.build(options: [@option])
  end


  def destroy
    @test = Test.find(params[:test_id])
    @option = @test.options.find(params[:id])
    message = if @option.destroy
      "Option deleted successfully."
    else
      @option.errors.first.message
    end

    respond_to do |format|
      format.html {
        redirect_back notice: message, fallback_location: admin_test_path(@test)
      }

      format.turbo_stream {
        flash.now[:notice] = message
      }
    end
  end

end
