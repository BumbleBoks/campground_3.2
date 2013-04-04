def create_trail
  state = FactoryGirl.create(:state) 
  FactoryGirl.create(:trail, state_id: state.id) 
end