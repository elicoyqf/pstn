# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  $("#datepicker1").datepicker(changeMonth: true)
  $("#datepicker2").datepicker(changeMonth: true)
  $("#datepicker3").datepicker(changeMonth: true)
#  $('#query_data_t1').hide()

  $('#q_b_s').click ->
    q_no    = $('#q_no').val()
    q_bt    = $('#q_bt').val()
    q_date1 = $('#datepicker1').val()
    q_date2 = $('#datepicker2').val()
    q_bs    = $('#q_bs').val()
    if q_no || q_bt || q_bs || q_date1 || q_date2
      if q_date1
        tmp1 = q_date1.replace("-","/").replace("-","/")
        d1 = new Date(Date.parse(tmp1))
      if q_date2
        tmp2 = q_date2.replace("-","/").replace("-","/")
        d2 = new Date(Date.parse(tmp2))
      if d1 && d2
        if d1 > d2
          $('#myModal').modal('show')
          return false
      $('#q_data_form').submit()
      ###$.post(
        "q_cont_data",
        {q_no: q_no,q_bt: q_bt,q_date1: q_date1,q_date2: q_date2,q_bs: q_bs}
        (data) ->
          $('#query_data_t1').show()
#          window.location.reload(true);
          alert data[0].sn
        "json"
      )###
    else
      $('#conModal').modal('show')
      return false
    return false


###    $('#q_data_form').validate
      rules:
        ctl00$ContentPlaceHolder1$ucProjInfo1$ucDatePicker2$txtDatePicker:
          endDate:true
###



#  $('#q_b_s').click ->
#    qdata("pstn_stop")

###
  qdata = (url) ->
    q_no    = $('#q_no').val()
    q_bt    = $('#q_bt').val()
    q_date1 = $('#datepicker1').val()
    q_date2 = $('#datepicker2').val()
    q_bs    = $('#q_bs').val()
    #    $('#showContent').hide()
    #    if !con && typeof(con) != "undefined" && con != 0
    if q_date1
      if q_date2
        if new Date(Date.parse(q_date1.replace("-", "/"))) > new Date(Date.parse(q_date2.replace("-", "/")))
          $('#date_error').show()
          return false
    else
      $.post(
        url,
        {number: con},
      (data) ->
        ###
###
         显示json数据
         jsonData = data[1].elico
         alert jsonData
        ###
###
        $('#showContent').hide()
        $('#show1').show()
        "json"
      )
      return false###
