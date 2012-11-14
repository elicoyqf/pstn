# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $.Placeholder.init()
  #  $('input, textarea').placeholder()
  $('#show1').hide()
  $('#show3').hide()
  $('#show4').hide()

  submitdata = (url, type) ->
    con = $('#cont1').val()
    $('#showContent').hide()
    if !con && typeof(con) != "undefined" && con != 0
      $('#showContent').hide()
      $('#show3').show()
      return false
    else
      $.post(
        url,
        {number: con, wo_type: type},
      (data) ->
        ###
         显示json数据
         jsonData = data[1].elico
         alert jsonData
        ###
        if data.length == 2
          $('#showContent').hide()
          $('#show4').show()
          false
        else
          $('#showContent').val("")
          false
        "json"
      )
      return false

  $('#pstn_stop').click ->
    submitdata("pstn_stop", 1)

  $('#pstn_badp').click ->
    submitdata("pstn_stop", 2)

  $('#pstn_deni').click ->
    submitdata("pstn_stop", 3)

  $('#pstn_reset').click ->
    submitdata("pstn_stop", 4)

  $('#dataR').click ->
    $('#show3').hide()
    $('#showContent').show()
    return false

  $('#sR').click ->
    $('#show1').hide()
    $('#cont1').val("")
    $('#showContent').show()
    return false

  $('#pdataR').click ->
    $('#show4').hide()
    $('#showContent').show()
    return false


#  $('#m_stop').click ->
#    $('#m_stop').attr("class","active")
#    $('#m_stop').append("class","active")