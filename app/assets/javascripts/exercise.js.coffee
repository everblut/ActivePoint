# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->

  $("#exercise_teacher_id").change ->
    isd = $("#exercise_teacher_id option:selected").val()
    url = "/fetch_courses/"+isd
    $.ajax url: url

  $("#exercise_course_id").change ->
    isd = $("#exercise_course_id option:selected").val()
    url = "/fetch_homeworks/"+isd
    $.ajax url: url
  	


$(document).ready(ready);
$(document).on('page:load', ready);