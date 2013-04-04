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
end
