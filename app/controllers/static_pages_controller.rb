class StaticPagesController < ApplicationController
  def home
    if params.has_key?(:trail_id)
      @trail = Common::Trail.find_by_id(params[:trail_id])
      @updates = @trail.updates.all
    else
      @trail = nil
      @updates = nil
    end
    respond_to do |format|
      format.html
      format.js
    end
  end

  def about
  end

  def contact
  end
end
