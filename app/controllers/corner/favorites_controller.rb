class Corner::FavoritesController < ApplicationController
  before_filter :authorize_user
  def show    
  end
  
  def new    
  end
  
  def create
    # TODO - refactor
    new_activity_ids = old_activity_ids = []
    new_trail_ids = old_trail_ids = []

    if params.has_key?(:user)
      new_activity_ids = params[:user][:activity_ids] if params[:user].has_key?(:activity_ids)
      new_trail_ids = params[:user][:trail_ids] if params[:user].has_key?(:trail_ids)
    end
    
    old_trail_ids = current_user.trail_ids.map { |id| id.to_s } unless current_user.trail_ids.nil?
    old_activity_ids = current_user.activity_ids.map { |id| id.to_s }  unless current_user.activity_ids.nil?
        
    set_favorite_attributes(old_activity_ids, new_activity_ids, :activities, Common::Activity)
    set_favorite_attributes(old_trail_ids, new_trail_ids, :trails, Common::Trail)
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
  
  private
  # TODO - refactor
  def set_favorite_attributes(old_attribute_ids, new_attribute_ids, attributes, collection)
    add_attribute_ids = new_attribute_ids - old_attribute_ids
    delete_attribute_ids = old_attribute_ids - new_attribute_ids
        
    if add_attribute_ids.any?
      add_attribute_ids.each do |attribute_id|
        current_user.send(attributes).push(collection.find_by_id(attribute_id))
      end
    end
    
    if delete_attribute_ids.any?
      delete_attribute_ids.each do |attribute_id|
        current_user.send(attributes).delete(collection.find_by_id(attribute_id))
      end
    end
    
  end
end
