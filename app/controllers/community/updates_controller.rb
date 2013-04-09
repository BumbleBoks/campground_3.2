class Community::UpdatesController < ApplicationController
  before_filter :authorize_user
  
  def create
    @update = current_user.updates.build(params[:community_update])
    if @update.save
      redirect_to @update.trail
    else
      redirect_to @update.trail
    end
  end
end
