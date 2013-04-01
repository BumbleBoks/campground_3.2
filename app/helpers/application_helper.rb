module ApplicationHelper
  def div_for_side_panes
    if logged_in? 
      div_name = "title_board"
    else
      div_name = "title_board inactive"
    end
  end
end
