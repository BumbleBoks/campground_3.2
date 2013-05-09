class Corner::FavoritesController < ApplicationController
  before_filter :authorize_user
  def show    
  end
  
  def new    
  end
  
  def create
    # TODO - refactor        
    new_activity_ids = params[:user][:activity_ids][1..-1].map { |el| el.to_i }
    new_trail_ids = params[:user][:trail_ids][1..-1].map { |el| el.to_i }
        
    current_user.set_favorite_attributes(new_activity_ids, :activities, Common::Activity)
    current_user.set_favorite_attributes(new_trail_ids, :trails, Common::Trail)
    redirect_to(favorites_show_path)
  end
  
  def add_trail
    current_user.trails.push(Common::Trail.find_by_id(params[:favorite_trail_id]))
    redirect_to(favorites_show_path)
  end
  
  def remove_trail
    current_user.trails.delete(Common::Trail.find_by_id(params[:favorite_trail_id]))
    redirect_to(favorites_show_path)
  end
  
end
