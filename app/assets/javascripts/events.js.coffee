# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  $("#e_q_date1").datepicker(changeMonth: true)
  $("#e_q_date2").datepicker(changeMonth: true)

  $("#e_q_submit").click ->
    q_bt    = $('#q_content').val()
    q_date1 = $('#e_q_date1').val()
    q_date2 = $('#e_q_date2').val()
    q_type  = $('#log_type').val()

    if q_bt || q_date1 || q_date2 || q_type
      if q_date1
        tmp1 = q_date1.replace("-","/").replace("-","/")
        d1 = new Date(Date.parse(tmp1))
      if q_date2
        tmp2 = q_date2.replace("-","/").replace("-","/")
        d2 = new Date(Date.parse(tmp2))
      if d1 && d2
        if d1 > d2
          $('#e_date_Modal').modal('show')
          return false
      $('#e_query').submit()
      true
    else
      $('#e_con_Modal').modal('show')
      false
    false

