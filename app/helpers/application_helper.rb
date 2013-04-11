module ApplicationHelper
  def div_for_side_panes
    if logged_in? 
      div_name = "title_board"
    else
      div_name = "title_board inactive"
    end
  end
  
  def authorize_admin
    unless current_user && current_user.admin?
      redirect_to root_path
      false
    end
  end
  
  def authorize_user
    unless current_user
      redirect_to root_path
      false
    end
  end
  
  def output_with_commas(elements, attribute)
    output_string = ""
    if elements.first.respond_to?(attribute)
      elements.each do |element|
        if !(element == elements.first) 
    			output_string += ", "
    		end
    		output_string += element.send(attribute).to_s 		    
      end
      output_string
    end
  end
  
end
