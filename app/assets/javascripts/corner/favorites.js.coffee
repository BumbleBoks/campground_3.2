# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $('#add_trail_button').click ->
    trail_id = $('#trail_id :selected').val()
    trail_in_favorites = false
    selected_trails = $("li input")
    trail_in_favorites = true for trail in selected_trails when $(trail).attr("value") is trail_id
    if trail_in_favorites == true
      alert("Trail already added to favorites!")
    if $("#hidden_request_path").html() == ("/favorites/new") && trail_in_favorites == false
      input_string = '<input id="user_trail_ids_" type="hidden" value="' + trail_id + 
        '" name="user[trail_ids][]">'
      trail_name = $('#trail_id :selected').text() + ', ' + $('#state_id :selected').text()
      link_string = ' <a id="delete_favorite_trail" href="#">delete</a>'
      append_string = input_string + trail_name + link_string
      $("#favorite_trails ul").append("<li></li>")
      $("#favorite_trails li").last().append(append_string)

  $('#favorite_trails ul').on 'click', $("a.delete_favorite_trail"), (event) ->
    $(event.target).closest('li').remove()
