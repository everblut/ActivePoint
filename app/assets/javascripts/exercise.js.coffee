# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
do_loading = ->
  config =
    text: "Cargando"
    position: "overlay"
  $("body").isLoading(config)
  return

@release = ->
  $("body").isLoading("hide")
  return

ready = ->
  $("#exercise_teacher_id").change ->
    isd = $("#exercise_teacher_id option:selected").val()
    url = "/fetch_courses/"+isd
    $.ajax url: url, beforeSend: do_loading, error: release
    return

  $("#exercise_course_id").change ->
    isd = $("#exercise_course_id option:selected").val()
    url = "/fetch_homeworks/"+isd
    $.ajax url: url, beforeSend: do_loading, error: release
    return

  $("#exercise_file").change ->
    $(".float-inp").text(this.value.replace(/^.*\\/, ""))
    return

$(document).ready(ready);
$(document).on('page:load', ready);
