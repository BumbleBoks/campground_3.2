class Corner::LogsController < ApplicationController
  before_filter :authorize_user
  def new
    @log = current_user.logs.build
  end
  
  def create      
    @log = current_user.logs.build(params[:corner_log])
    if @log.save
      flash[:success] = "Log successfully added"
      redirect_to @log
    else
      render 'new'
    end
  end
    
  def show
    @log = current_user.logs.find_by_id(params[:id])
  end
end
