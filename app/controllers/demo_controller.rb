class DemoController < ApplicationController
  
  layout "admin"

  def index
  	#render('index')
  	#redirect_to(:action => 'other_hello')
  end

  def hello
    @array = [1,2,3,4,5]
    @id = params[:id].to_i
    @page = params[:page].to_i
  end

  def other_hello
  	render(:text => "Hello everybody!!")
  end

  def javascript
  end

  def text_helpers
  end

  def escape_output
  end

  def make_error
    #render(:text => "test"
    #  render(:text => @something.upcase)
    #  render(:text => "1" + 1)
    logger.debug("hey guys!! it's me lol")
    render("index")
    ActiveSupport::Deprecation.warn("deprecation hey lol hahah")
  end

end
