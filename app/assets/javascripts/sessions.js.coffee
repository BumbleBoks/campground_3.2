# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $('#forgot_password').submit ->
    $("#login_id_error").empty()    
    login_id = $("#login_id").val().trim()
    if login_id == ""
      $("#login_id_error").html("Login ID is required")
      return false
    else
      $("#user_login_id").val(login_id)
      return true
