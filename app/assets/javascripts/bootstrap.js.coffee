ready = ->
  $("div.fileinput").tooltip()

  $(".btnmodal").click (e) ->
    e.preventDefault()
    a = 0
    if $("#exercise_teacher_id option:selected").val() isnt `undefined`
      $("#modalteacher").text "Maestro : "+ $("#exercise_teacher_id option:selected").text()
    else
      a = 1
    if $("#exercise_course_id option:selected").val() isnt `undefined`
      $("#modalcourse").text "Curso : "+ $("#exercise_course_id option:selected").text()
    else
      a = 1
    if $("#exercise_homework_id option:selected").val() isnt `undefined`
      $("#modalhomework").text "Tarea : "+ $("#exercise_homework_id option:selected").text()
    else
      a = 1
    if a is 1
      $("#modalwarning").show()
      $(".btnsubmit").hide()
    else
      $("#modalwarning").hide()
      $(".btnsubmit").show()
    $(".modal").modal "toggle"

  $(".btnsubmit").click ->
    $(".btnsubmit").attr("disabled",true)
    $("form[id=new_exercise]").submit()



$(document).ready(ready);
$(document).on('page:load', ready);
