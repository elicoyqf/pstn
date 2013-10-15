require 'set'

class GponController < ApplicationController
  def preconfig

    render layout: 'main_layout'
  end

  def g_command
    #gd1
    olt_id  = params[:preconfig][:olt_id].to_s.strip
    #0011
    port    = params[:preconfig][:port].to_s.strip
    #3
    line_id = params[:preconfig][:line_id].to_s.strip
    #3
    srv_id  = params[:preconfig][:srv_id].to_s.strip
    #1001
    pe_vlan = params[:preconfig][:pe_vlan].to_s.strip
    #1386
    ce_vlan = params[:preconfig][:ce_vlan].to_s.strip
    #32
    cmd_no  = params[:preconfig][:cmd_no].to_s.strip

    if port.size != 4 || olt_id.size != 3
      render layout: 'main_layout', template: 'gpon/error'
    else
      @passwd,@ont_str = ont_make(port[3], olt_id + port, line_id, srv_id, cmd_no.to_i)
      @sp_str = service_port_make(pe_vlan, port[0]+'/'+port[1..2]+'/'+port[3], ce_vlan.to_i, cmd_no.to_i)
      render layout: 'preconfig_layout'
    end
  end

  private
  #ont_make(6, 'gd10066', 3, 3,32)
  #service_port_make(1318, '0/6/6', 1161,32)

  def newpass(len, prefix='')
    chars   = ("a".."z").to_a + ("0".."9").to_a
    newpass = prefix.dup
    1.upto(len) { newpass << chars[rand(chars.size-1)] }
    newpass
  end

  def ont_make(port, pass_prefix, lineid, srvid, count)
    pass_set = Set[]
    ont_str = []
    (1..count).each {  pass_set << newpass(3, pass_prefix) }
    if pass_set.size == count
      pass_set.each { |s| puts s }
    end

    if pass_set.size == count
      pass_set.each_with_index do |set, index|
        t   = index + 64
        tmp =''
        if t < 100
          tmp = t.to_s.ljust(3)
        else
          tmp = t
        end
        ont_str << "ont add #{port} #{tmp} password-auth #{set} always-on no-aging omci ont-lineprofile-id #{lineid} ont-srvprofile-id #{srvid}"
      end
    end
    [pass_set,ont_str]
  end

  def service_port_make(pvlan, portinfo, cvlan, count)
    sp_str = []
    (1..count).each do |index|
      t   = index + 63
      tmp =''
      if t < 100
        tmp = t.to_s.ljust(3)
      else
        tmp = t
      end
      sp_str << "service-port vlan #{pvlan} port #{portinfo} ont #{tmp} eth 1 multi-service user-vlan untagged tag-transform add-double inner-vlan #{cvlan+index-1} inner-priority 0"
    end
    sp_str
  end
end
