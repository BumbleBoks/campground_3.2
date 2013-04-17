module Community::UpdatesHelper
  def wrap(content)
    sanitize(raw(content.split.map{ |s| wrap_long_string(s) }.join(' ') ))
  end
  
  def wrap_long_string(text, max_width=50)
    zero_width_space = "&#8203;"
    regex = /.{1,#{max_width}}/
    (text.length < max_width) ? text : text.scan(regex).join(zero_width_space)
  end
  
  def render_update_partial(updates, show_trail_name = true)
    render partial: 'shared/update', collection: updates, 
			locals: {show_trail_name: show_trail_name} 
  end
    
end
