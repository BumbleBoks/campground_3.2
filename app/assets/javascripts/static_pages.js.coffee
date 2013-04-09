# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  set_trail_html = (trails) ->
    activity = $('#activity_id :selected').text()
    state = $('#state_id :selected').text()
    if activity == 'Select an activity' || state == 'Select a state'
    else
      options = $(trails).filter("optgroup[label='#{state},#{activity}']").html()
    if options 
      $('#trail_id').html(options)
      $('#trail_id').show()
      $('#get_updates_button').show()
      $('#trail_selection_message').hide()
    else
      $('#trail_id').hide()
      $('#get_updates_button').hide()
      $('#trail_selection_message').show()	
	
  trails = $('#trail_id').html()
  $('#trail_id').hide()
  $('#get_updates_button').hide()
  $('#trail_selection_message').hide()

  $('#state_id').change ->
    set_trail_html(trails)

  $('#activity_id').change ->
    set_trail_html(trails)

  $('#get_updates_button').click ->
    trail_id = $('#trail_id :selected').val()
    newhref = '/?trail_id=' + trail_id
    $('#get_updates_button').attr("href", newhref)