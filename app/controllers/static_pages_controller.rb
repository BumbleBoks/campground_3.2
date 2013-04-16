class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @updates = []
      if current_user.trails.any?
        @updates = Community::Update.where(trail_id: current_user.trail_ids)
      end
    else
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
  end

  def about
  end

  def contact
  end
end
