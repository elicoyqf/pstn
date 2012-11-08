# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $.Placeholder.init()
  #  $('input, textarea').placeholder()
  $('#show1').hide()
  $('#show3').hide()

  submitdata = (url, type, emerg) ->
    con = $('#cont1').val()
    $('#showContent').hide()
    if !con && typeof(con) != "undefined" && con != 0
      $('#showContent').hide()
      $('#show3').show()
      return false
    else
      $.post(
        url,
        {number: con, wo_type: type, emerg: emerg},
      (data) ->
        ###
         显示json数据
         jsonData = data[1].elico
         alert jsonData
        ###
        $('#showContent').hide()
        $('#show1').show()
        "json"
      )
      return false

  $('#pstn_stop').click ->
    submitdata("pstn_stop", 1, 0)

  $('#pstn_badp').click ->
    submitdata("pstn_stop", 2, 0)

  $('#pstn_deni').click ->
    submitdata("pstn_stop", 3, 0)

  $('#pstn_reset').click ->
    submitdata("pstn_stop", 4, 0)

  $('#i_pstn_stop').click ->
    submitdata("pstn_stop", 1, 1)

  $('#i_pstn_badp').click ->
    submitdata("pstn_stop", 2, 1)

  $('#i_pstn_deni').click ->
    submitdata("pstn_stop", 3, 1)

  $('#i_pstn_reset').click ->
    submitdata("pstn_stop", 4, 1)

  $('#reverse_pstn_stop').click ->
    submitdata("pstn_stop", 51, 0)

  $('#reverse_pstn_badp').click ->
    submitdata("pstn_stop", 52, 0)

  $('#reverse_pstn_deni').click ->
    submitdata("pstn_stop", 53, 0)

  $('#i_reverse_pstn_stop').click ->
    submitdata("pstn_stop", 51, 1)

  $('#i_reverse_pstn_badp').click ->
    submitdata("pstn_stop", 52, 1)

  $('#i_reverse_pstn_deni').click ->
    submitdata("pstn_stop", 53, 1)

  $('#dataR').click ->
    $('#show3').hide()
    $('#showContent').show()
    return false

  $('#sR').click ->
    $('#show1').hide()
    $('#cont1').val("")
    $('#showContent').show()
    return false

#  $('#m_stop').click ->
#    $('#m_stop').attr("class","active")
#    $('#m_stop').append("class","active")