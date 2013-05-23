# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  userDate = null;
  if window.location.pathname.contains('new') == false  
    patharray = window.location.pathname.split("/")
    length = patharray.length
    if length == 6
      userDate = new Date()
      userDate.setDate(patharray[length-1])
      userDate.setMonth(patharray[length-2]-1)
      userDate.setFullYear(patharray[length-3])
    $("#corner_log_log_date").bind 'date_change', (event) ->
      selectedDate = datePicker.selectedDate
      year = selectedDate.getFullYear()
      month = selectedDate.getMonth() + 1
      day = selectedDate.getDate()
      new_url = ['/corner/logs', year, month, day].join('/')
      location.replace new_url

  if !datePicker
    datePicker = new DatePicker
  datePicker.initialize($("#date_picker"), $("#corner_log_log_date"), userDate)
      
