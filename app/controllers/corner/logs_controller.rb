class Corner::LogsController < ApplicationController
  before_filter :authorize_user
  
  def index
    
  end
  
  def new
    @log = current_user.logs.build
  end
  
  def create      
    @log = current_user.logs.build(params[:corner_log])
    if @log.save
      flash[:success] = "Log successfully added"
      log_params = { year: @log.log_date.year.to_s, 
                 month: @log.log_date.month.to_s,
                 day: @log.log_date.day.to_s }
      redirect_to corner_logs_path(log_params)
    else
      render 'new'
    end
  end
    
  def show
    @log = current_user.logs.find_by_log_date(Date.new(params[:year].to_i, 
      params[:month].to_i, params[:day].to_i))
    # respond_to do |format|
    #   format.html
    #   format.js
    # end
  end
end
