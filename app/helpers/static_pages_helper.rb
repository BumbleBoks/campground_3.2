module StaticPagesHelper
  # add method to get collection - tags for optgroup (state, activity) - array
  # add group method to collect all the option tags for state, activtity - method on collection
  # group_label_method - label for optgroup tag
  # option_groups_from_collection_for_select(collection, group_method, group_label_method, 
  #   option_key_method, option_value_method, selected_key = nil)
  def state_activity
    states = Common::State.all
    activities = Common::Activity.all
    trails = Common::Trail.includes(:activity_associations)
    categories = []
    states.each do |state|
      activities.each do |activity|
        categories << StateActivity.new(state, activity, trails)          
      end
    end
    categories
  end
  
  class StateActivity < Struct.new(:state, :activity, :trails)

    def trail_collection
      # Common::Trail.where('state_id' => state.id).joins(:activity_associations).where('common_activity_associations.activity_id' => activity.id)
      trails.select do |trail|
        trail_with_activity = trail.activity_associations.select { |association| association.activity_id == activity.id }      
        trail.state_id == state.id && !trail_with_activity.empty?
      end
    end
    
    def category_label
      state.name + "," + activity.name
    end
  end
end
