# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $('#show1').hide()
  $('#show3').hide()
  $('#show4').hide()
  $('#show5').hide()
  $('#pop').popover({trigger: "hover"})
  $('#tp').tooltip({selector: "a[rel=tooltip]"})

  $("#b_logic_form").validate()
  #  $("a[rel=popover]").popover({trigger: 'hover' })
  #  $("#p_1").popover('toggle')


  $('#s_b_s').click ->
    if $("#b_logic_form").valid() == false
      $('#content').hide()
      $('#show3').show()
      return false
    b_s_no = $('#b_s_no').val()
    s_no   = $('#s_no').val()
    s_bt   = $('#s_bt').val()
    s_perm = $('#s_perm').val()
    s_cf   = $('#s_cf').val()
    s_cf_no= $('#s_cf_no').val()
    s_cr_no= $('#s_cr_no').val()
    s_df_flag = $('#s_df_flag').val()
    s_sg_no = $('#s_sg_no').val()
    s_bp = $('#s_bp').val()
    if s_cr_no == "默认密码为8888"
      s_cr_no = ""
    else
      s_cr_no = $('#s_cr_no').val()
    ###$("input[name='ns']:checked").each( ->
      alert $(this).val()
    )###
    s_hs = $('#s_hs').val()
    s_mc = $('#s_mc').val()
    s_cr = $('#s_cr').val()
    s_ad = $('#s_ad').val()
    s_cid = $('#s_cid').val()
    ###if $('#s_hs').attr("checked") != undefined
      s_hs = "hs"
    if $('#s_mc').attr("checked") != undefined
      s_mc = "mc"
    if $('#s_cr').attr("checked") != undefined
      s_cr = "cr"
    if $('#s_ad').attr("checked") != undefined
      s_ad = "ad"
    if $('#s_cid').attr("checked") != undefined
      s_cid = "cid"###

    if !s_bp && !b_s_no && !s_no && !s_bt && !s_perm && !s_cf && !s_hs && !s_mc && !s_cr && !s_ad && !s_cr_no && !s_df_flag && !s_sg_no && !s_cf_no && !s_cid
      $("#conModal").modal('show')
      false
    else if b_s_no || s_no
      if b_s_no && s_no
        $("#noModal").modal('show')
        false
      else if s_bt && s_sg_no
        $('#content').hide()
        $('#show5').show()
        false
      else
        if s_df_flag && !s_bt && !s_sg_no
          $("#dfModal").modal('show')
          #todo:此处是如果选择了欠费标志，则必须要选择用户组号，否则没有办理进行处理。
        else if s_bt || s_perm || s_cf || s_hs || s_mc || s_cr || s_ad || s_cr_no || s_df_flag || s_sg_no || s_cf_no
          $.post(
            "bl_submit",
            {
            b_s_no: b_s_no, s_no: s_no, s_bt: s_bt, s_perm: s_perm, s_cf: s_cf,
            s_cf_no: s_cf_no, s_hs: s_hs, s_mc: s_mc, s_cr: s_cr, s_cr_no: s_cr_no,
            s_ad: s_ad, s_df_flag: s_df_flag, s_sg_no: s_sg_no, s_cid: s_cid,s_bp:s_bp
            },
          (data) ->
            if data.length == 2
              $('#content').hide()
              $('#show4').show()
              false
            else
              $('#content').hide()
              $('#show1').show()
              #清空原有数据
              $('#b_s_no').val("")
              $('#s_no').val("")
              $('#s_bt').val("")
              $('#s_perm').val("")
              $('#s_cf').val("")
              $('#s_cf_no').val("")
              $('#s_hs').val("")
              $('#s_mc').val("")
              $('#s_cr').val("")
              $('#s_cr_no').val("")
              $('#s_ad').val("")
              $('#s_df_flag').val("")
              $('#s_sg_no').val("")
              $('#s_bp').val("")
              $('#s_hs').val("")
              $('#s_mc').val("")
              $('#s_cr').val("")
              $('#s_ad').val("")
              $('#s_cid').val("")
              ###$("input[name='ns']:checked").each(->
                $(this).attr("checked", false)
              )###
              false
            "json"
          )
        else
          $("#conModal").modal('show')
    else
      $("#conModal").modal('show')
    ###$('#content').hide()
    $('#show3').show()###
    false

  $('#dataR').click ->
    $('#show3').hide()
    $('#content').show()
    return false

  $('#sR').click ->
    $('#show1').hide()
    $('#content').show()
    return false

  $('#bdataR').click ->
    $('#show4').hide()
    $('#content').show()
    return false

  $('#gdataR').click ->
    $('#show5').hide()
    $('#content').show()
    return false
