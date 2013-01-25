#encoding : utf-8
module WorkOrderProcess
  class BackgroundProcedure
    def testrake
      puts 'hello'
    end

    def wo_make(new_or)
      #优先做新装业务，即优先级为1的(work_orders:priotity = 1)
      #状态2为等等中，1为成功，3为失败。
      #new_or = WorkOrder.where('created_at >= ? And created_at <= ? and status = ?', Time.now.at_beginning_of_day,
      #                         Time.now.at_beginning_of_day + 1.day, 2)

      new_or.each do |x|
        no    = x.s_no.to_i
        s_cr  = x.s_cr
        cr_no = x.s_cr_no
        cf_no = x.s_cf_no
        bt    = x.s_bt
        sg_no = x.s_sg_no
        perm  = x.s_perm
        dn    = DnTable.includes(:jf_name).where("dn_start <= ? and ? <= dn_end ", no, no).first

        #条件：机房登录状态必须为1(jf_name:status == 1)
        if dn.jf_name.status == 1
          unless dn.blank?
            #终端IP地址
            #生成命令行字符串
            ip_address = dn.jf_name.ip_address
            #jf_py      = HanziToPinyin.hanzi_to_pinyin(dn.jf_name.name)
            cmd        = ""
            df_cmd     = ""
            r_cmd      = cmd
            subctrl    = 'subctrl=1'
            r_subctrl  = 'subctrl=2'
            ad_cmd     = ""
            cf_no_cmd  = ""
            cf_act     = ""
            cf_act_cmd = ""
            perm_cmd   = ""
            test_r     = []
            p_nat      = dn.jf_name.p_nat
            p_local    = dn.jf_name.p_local
            p_suburban = dn.jf_name.p_suburban
            p_int      = dn.jf_name.p_int
            p_emerg    = dn.jf_name.p_emerg

            #todo:需要在用户类型和组号二选一，已经在前台完成限制了，后台不用管它。
            (cmd += "4294:dn=k'#{no},subgrp=#{bt}"; test_r << "SUBGRP  :  #{bt}") unless x.s_bt.blank?
            (cmd += "4294:dn=k'#{no},subgrp=#{sg_no}"; test_r << "SUBGRP  :  #{sg_no}") unless x.s_sg_no.blank?
            #todo:用户权限的生成字符串还需要根据不同机房生成不同的权限字符
            #"国内" => "1", "市话" => "2", "郊话" => "3", "国际" => "4", "紧急" => "5"
            #各个机房的权限已经放到jf_name里面p_nat,p_local,p_suburban,p_int,p_emerg.
            unless perm.blank?
              case perm
                when '1'
                  perm_cmd = ",ocb=modify&perm&#{p_nat}"
                  test_r << "PERM      #{p_nat}"
                when '2'
                  perm_cmd = ",ocb=modify&perm&#{p_local}"
                  test_r << "PERM      #{p_local}"
                when '3'
                  perm_cmd = ",ocb=modify&perm&#{p_suburban}"
                  test_r << "PERM      #{p_suburban}"
                when '4'
                  perm_cmd = ",ocb=modify&perm&#{p_int}"
                  test_r << "PERM      #{p_int}"
                when '5'
                  perm_cmd = ",ocb=modify&perm&#{p_emerg}"
                  test_r << "PERM      #{p_emerg}"
                else

              end
              cmd += perm_cmd
            end

            #欠费标志需要细化
            #{ "放欠费" => "1", "欠费停机" => "2", "停机保号" => "3", "拆机" => "4",
            #"去欠费" => "51","去欠费开机" => "52","开机"  => "53" }
            unless x.s_df_flag.blank?
              case x.s_df_flag
                when '1'
                  df_cmd += "4294:dn=k'#{no},subgrp=18."
                when '2'
                  df_cmd += "4294:dn=k'#{no},subgrp=18,intcp=badp."
                when '3'
                  df_cmd += "4294:dn=k'#{no},subgrp=18,intcp=deni."
                when '4'
                  df_cmd += "4294:dn=k'#{no},subgrp=1,23=2&1,ocb=modify&perm&#{p_emerg},intcp=deni."
                else
                  cmd += ",intcp=remove"
              end
            end

            unless x.s_cid.blank?
              if x.s_cid == '1'
                cmd += ",23=1&1"; test_r << "CGLIP"
              else
                r_cmd += ",23=2&1"; test_r << "CGLIP"
              end
            end

            unless x.s_ad.blank?
              if x.s_ad == '1'
                ad_cmd = "141:dn=k'#{no},abdrepsz=20."
              else
                ad_cmd = "142:dn=k'#{no}."
              end
            end

            case x.s_cf
              when "1"
                subctrl += '&cfwdu'
                cf_act  = 'cfwdu'
                test_r << 'CFWDU'
                unless cf_no.blank?
                  cf_no_cmd  = "4294:dn=k'#{no},cfwd=add&#{cf_act}&k'#{cf_no}."
                  cf_act_cmd = "4294:dn=k'#{no},cfwd=activate&#{cf_act}&k'#{cf_no}."
                  test_r << 'ACTIVATE'
                end
              when "2"
                subctrl += '&cfwdbsub'
                cf_act  = 'cfwdbsub'
                test_r << 'CFWDBSUB'
                unless cf_no.blank?
                  cf_no_cmd  = "4294:dn=k'#{no},cfwd=add&#{cf_act}&k'#{cf_no}."
                  cf_act_cmd = "4294:dn=k'#{no},cfwd=activate&#{cf_act}&k'#{cf_no}."
                  test_r << 'ACTIVATE'
                end
              when "3"
                subctrl += '&cfwdnor'
                cf_act  = 'cfwdnor'
                test_r << 'CFWDNOR'
                unless cf_no.blank?
                  cf_no_cmd  = "4294:dn=k'#{no},cfwd=add&#{cf_act}&k'#{cf_no}."
                  cf_act_cmd = "4294:dn=k'#{no},cfwd=activate&#{cf_act}&k'#{cf_no}."
                  test_r << "ACTIVATE"
                end
              when "4"
                r_subctrl += '&cfwdu'
                cf_act    = 'cfwdu'
                test_r << 'CFWDU'

                cf_no_cmd = "4294:dn=k'#{no},cfwd=remove."
                #cf_act_cmd = "4294:dn=k'#{no},#{r_subctrl}."
                test_r << 'ACTIVATE'

              when "5"
                r_subctrl += '&cfwdbsub'
                cf_act    = 'cfwdbsub'
                test_r << 'CFWDBSUB'

                cf_no_cmd = "4294:dn=k'#{no},cfwd=remove."
                #cf_act_cmd = "4294:dn=k'#{no},#{r_subctrl}."
                test_r << 'ACTIVATE'

              when "6"
                r_subctrl += '&cfwdnor'
                cf_act    = 'cfwdnor'
                test_r << 'CFWDNOR'

                cf_no_cmd = "4294:dn=k'#{no},cfwd=remove."
                #cf_act_cmd = "4294:dn=k'#{no},#{r_subctrl}."
                test_r << 'ACTIVATE'

              else

            end unless x.s_cf.blank?

            unless s_cr.blank?
              if s_cr == "1"
                if cr_no.blank?
                  cmd     += ',password=1&'+"\""+'8888'+"\""
                  subctrl += '&ocbvar'
                  test_r << 'PASSWORD'
                else
                  cmd     += ",password=1&"+"\""+"#{cr_no}"+"\""
                  subctrl += '&ocbvar'
                  test_r << 'PASSWORD'
                end
              else
                r_subctrl += '&ocbvar'
                #还需要加上"password=2"
                r_cmd     += ',password=2'
              end
            end

            unless  x.s_hs.blank?
              if x.s_hs == '1'
                subctrl += '&fdcto'
                test_r << 'FDCTO'
              else
                r_subctrl += '&fdcto'
              end
            end

            unless  x.s_mc.blank?
              if x.s_mc == '1'
                subctrl += '&ac24hour'
                test_r << 'AC24HOUR'
              else
                r_subctrl += "&ac24hour"
              end
            end

            if r_subctrl !~ /^subctrl=2$/
              r_cmd += ','+r_subctrl+"."
            else
              r_cmd += '.'
            end

            if subctrl =~ /^subctrl=1$/
              cmd += "."
            else
              cmd += ","+subctrl+ "."
            end

            puts x.id
            #如果cmd或者r_cmd没有数据，则不发送到终端。
            if r_cmd =~/4294:dn=k'#{no}.$/
              puts '不发送命令'
            else

            end

            if cmd =~/4294:dn=k'#{no}.$/
              puts '不发送命令'
            else

            end
            puts "cmd---->"+cmd
            #cf_no_cmd在删除的时候需要在r_cmd的前面。
            puts "cf_no_cmd---->"+cf_no_cmd
            puts "cf_act_cmd---->"+cf_act_cmd
            puts "r_cmd---->"+r_cmd
            puts "df_cmd---->"+df_cmd
            puts "ad_cmd---->"+ad_cmd
            puts "test_r---->"+test_r.to_s

            pstn_data(ip_address, x.id, cmd, ad_cmd, cf_no_cmd, cf_act_cmd, df_cmd)
          end
        end
      end
    end

    def pstn_data(ip_address, id, cmd, ad_cmd='', cf_no_cmd='', cf_act_cmd='', df_cmd='')
      telnet = Net::Telnet.new(
          "Host"     => ip_address,
          "Port"     => 10001,
          "Timeout"  => 10,
          "Waittime" => 5
      )

      begin
        telnet.puts "\n"
        telnet.puts "\n"
        telnet.puts "\n"

        #timeout(10) {
        #}
        telnet.waitfor(/>/) { |c| print c }
        telnet.puts 'MM'

        telnet.waitfor(/USERID:/) { |c| print c }
        telnet.puts 'PW0009'

        telnet.waitfor(/PASSWORD:/) { |c| print c }
        telnet.puts 'PW0009'

        st = 1 #默认是成功的，如果遇到不妥的情况修改状态为3（失败）
               #普通号码测试使用6994951
               #telnet.puts "4294:dn=k'6994951,subgrp=5."
        telnet.puts "#{cmd}"
        r_cmd_str = telnet.waitfor(/>/) { |c| print c }

        #说明返回错误了
        if r_cmd_str =~ /ERROR: UNRECOGNIZED COMMAND/
          WorkOrder.find(id).update_attribute(:status, 3)
        else
          #todo:还需要判断用户是否是BCG用户，如果是BCG用户需要修改命令
          #判断其是不是BCG用户需要查询返回结果是否包含了BCG字样,测试号码:6118101
          if r_cmd_str =~ /BCG/
            telnet.puts "MM"
            telnet.waitfor(/</) { |c| print c }
            bcg_cmd = cmd.gsub(/4294/, '4382')
            telnet.puts "#{bcg_cmd}"
            bcg_r_cmd_str = telnet.waitfor(/>/) { |c| print c }
            st = 3 if bcg_r_cmd_str =~ /ERROR: UNRECOGNIZED COMMAND/

            unless cf_no_cmd.blank?
              telnet.puts "MM"
              telnet.waitfor(/</) { |c| print c }
              bcg_cf_no_cmd = cf_no_cmd.gsub(/4294/, '4382')
              telnet.puts "#{bcg_cf_no_cmd}"
              bcg_r_cf_no_str = telnet.waitfor(/>/) { |c| print c }
              st = 3 if bcg_r_cf_no_str =~ /ERROR: UNRECOGNIZED COMMAND/
            end

            unless cf_act_cmd.blank?
              telnet.puts "MM"
              telnet.waitfor(/</) { |c| print c }
              bcg_cf_act_cmd = cf_act_cmd.gsub(/4294/, '4382')
              telnet.puts "#{bcg_cf_act_cmd}"
              bcg_r_cf_act_str = telnet.waitfor(/>/) { |c| print c }
              st = 3 if bcg_r_cf_act_str =~ /ERROR: UNRECOGNIZED COMMAND/
            end

            unless df_cmd.blank?
              telnet.puts "MM"
              telnet.waitfor(/</) { |c| print c }
              bcg_df_cmd = df_cmd.gsub(/4294/, '4382')
              telnet.puts "#{bcg_df_cmd}"
              bcg_r_df_str = telnet.waitfor(/>/) { |c| print c }
              st = 3 if bcg_r_df_str =~ /ERROR: UNRECOGNIZED COMMAND/
            end

          else
            unless cf_no_cmd.blank?
              telnet.puts "MM"
              telnet.waitfor(/</) { |c| print c }
              telnet.puts "#{cf_no_cmd}"
              r_cf_no_cmd_str = telnet.waitfor(/>/) { |c| print c }
              st = 3 if r_cf_no_cmd_str =~ /ERROR: UNRECOGNIZED COMMAND/
            end

            unless cf_act_cmd.blank?
              telnet.puts "MM"
              telnet.waitfor(/</) { |c| print c }
              telnet.puts "#{cf_act_cmd}"
              r_cf_act_cmd_str = telnet.waitfor(/>/) { |c| print c }
              st = 3 if r_cf_act_cmd_str =~ /ERROR: UNRECOGNIZED COMMAND/
            end

            unless df_cmd.blank?
              telnet.puts "MM"
              telnet.waitfor(/</) { |c| print c }
              telnet.puts "#{df_cmd}"
              r_df_cmd_str = telnet.waitfor(/>/) { |c| print c }
              st = 3 if r_df_cmd_str =~ /ERROR: UNRECOGNIZED COMMAND/
            end

          end

          unless ad_cmd.blank?
            telnet.puts "MM"
            telnet.waitfor(/</) { |c| print c }
            telnet.puts "#{ad_cmd}"
            r_ad_cmd_str = telnet.waitfor(/>/) { |c| print c }
            st = 3 if r_ad_cmd_str =~ /ERROR: UNRECOGNIZED COMMAND/
          end
        end

      rescue
        #为了防止未超时的会话，直接输入命令即可。
        #todo:还需要判断用户是否是BCG用户，如果是BCG用户需要修改命令
        #判断其是不是BCG用户需要查询返回结果是否包含了BCG字样
        #普通号码测试使用6994951
        #telnet.puts "4294:dn=k'6994951,subgrp=5."
        telnet.puts "#{cmd}"
        r_cmd_str = telnet.waitfor(/>/) { |c| print c }

        #说明返回错误了
        if r_cmd_str =~ /ERROR: UNRECOGNIZED COMMAND/
          WorkOrder.find(id).update_attribute(:status, 3)
        else
          #todo:还需要判断用户是否是BCG用户，如果是BCG用户需要修改命令
          #判断其是不是BCG用户需要查询返回结果是否包含了BCG字样,测试号码:6118101
          if r_cmd_str =~ /BCG/
            telnet.puts "MM"
            telnet.waitfor(/</) { |c| print c }
            bcg_cmd = cmd.gsub(/4294/, '4382')
            telnet.puts "#{bcg_cmd}"
            bcg_r_cmd_str = telnet.waitfor(/>/) { |c| print c }
            st = 3 if bcg_r_cmd_str =~ /ERROR: UNRECOGNIZED COMMAND/

            unless cf_no_cmd.blank?
              telnet.puts "MM"
              telnet.waitfor(/</) { |c| print c }
              bcg_cf_no_cmd = cf_no_cmd.gsub(/4294/, '4382')
              telnet.puts "#{bcg_cf_no_cmd}"
              bcg_r_cf_no_str = telnet.waitfor(/>/) { |c| print c }
              st = 3 if bcg_r_cf_no_str =~ /ERROR: UNRECOGNIZED COMMAND/
            end

            unless cf_act_cmd.blank?
              telnet.puts "MM"
              telnet.waitfor(/</) { |c| print c }
              bcg_cf_act_cmd = cf_act_cmd.gsub(/4294/, '4382')
              telnet.puts "#{bcg_cf_act_cmd}"
              bcg_r_cf_act_str = telnet.waitfor(/>/) { |c| print c }
              st = 3 if bcg_r_cf_act_str =~ /ERROR: UNRECOGNIZED COMMAND/
            end

            unless df_cmd.blank?
              telnet.puts "MM"
              telnet.waitfor(/</) { |c| print c }
              bcg_df_cmd = df_cmd.gsub(/4294/, '4382')
              telnet.puts "#{bcg_df_cmd}"
              r_df_cmd_str = telnet.waitfor(/>/) { |c| print c }
              st = 3 if r_df_cmd_str =~ /ERROR: UNRECOGNIZED COMMAND/
            end

          else
            unless cf_no_cmd.blank?
              telnet.puts "MM"
              telnet.waitfor(/</) { |c| print c }
              telnet.puts "#{cf_no_cmd}"
              r_cf_no_cmd_str = telnet.waitfor(/>/) { |c| print c }
              st = 3 if r_cf_no_cmd_str =~ /ERROR: UNRECOGNIZED COMMAND/
            end

            unless cf_act_cmd.blank?
              telnet.puts "MM"
              telnet.waitfor(/</) { |c| print c }
              telnet.puts "#{cf_act_cmd}"
              r_cf_act_cmd_str = telnet.waitfor(/>/) { |c| print c }
              st = 3 if r_cf_act_cmd_str =~ /ERROR: UNRECOGNIZED COMMAND/
            end

            unless df_cmd.blank?
              telnet.puts "MM"
              telnet.waitfor(/</) { |c| print c }
              telnet.puts "#{df_cmd}"
              r_df_cmd_str = telnet.waitfor(/>/) { |c| print c }
              st = 3 if r_df_cmd_str =~ /ERROR: UNRECOGNIZED COMMAND/
            end

          end

          unless ad_cmd.blank?
            telnet.puts "MM"
            telnet.waitfor(/</) { |c| print c }
            telnet.puts "#{ad_cmd}"
            r_ad_cmd_str = telnet.waitfor(/>/) { |c| print c }
            st = 3 if r_ad_cmd_str =~ /ERROR: UNRECOGNIZED COMMAND/
          end
        end
      ensure
        WorkOrder.find(id).update_attribute(:status, st)
        telnet.close
      end
    end
  end
end