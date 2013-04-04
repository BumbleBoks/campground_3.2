class Common::TrailsController < ApplicationController
  before_filter :authorize_admin, except: [:show]
  
  def show
    @trail = Common::Trail.find_by_id(params[:id])
  end
  
  def new
    @trail = Common::Trail.new
  end
  
  def create
    @trail = Common::Trail.new(params[:common_trail])
    if @trail.save
      redirect_to(edit_common_trail_path(@trail))
    else
      render 'new'
    end
  end
  
  def edit
    @trail = Common::Trail.find_by_id(params[:id])
  end
  
  def update
    @trail = Common::Trail.find_by_id(params[:id])
    
    if @trail.update_attributes(params[:common_trail])
      redirect_to(edit_common_trail_path(@trail))
    else
      redirect_to(edit_common_trail_path(@trail))
    end
  end
end
