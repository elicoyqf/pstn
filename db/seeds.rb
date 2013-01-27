#encoding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Department.create(name:'网维中心',f_node: 0)
Department.create(name:'数据中心',f_node: 0)

User.create(name: 'yiqf', password: 'e10adc3949ba59abbe56e057f20f883e', level: 3, alias_name: '易其锋')
User.create(name: 'wuyk', password: 'e10adc3949ba59abbe56e057f20f883e', level: 3, alias_name: '吴艳开')
User.create(name: 'guanyc', password: 'e10adc3949ba59abbe56e057f20f883e', level: 3, alias_name: '官英才')
User.create(name: 'test', password: 'e10adc3949ba59abbe56e057f20f883e', level: 1, alias_name: '测试员')

JfName.create(name: '南郊', ip_address: '192.166.16.11', status: 1, p_nat: 3, p_local: 4, p_suburban: 2, p_int: 5, p_emerg: 1)
JfName.create(name: '南枫', ip_address: '192.166.16.8', status: 1, p_nat: 'nat', p_local: 'local', p_suburban: 'suburban', p_int: 'int', p_emerg: 'emerg')
JfName.create(name: '茗雅', ip_address: '192.166.16.4', status: 1, p_nat: 4, p_local: 2, p_suburban: 3, p_int: 5, p_emerg: 1)
JfName.create(name: '工业西', ip_address: '192.166.16.10', status: 1, p_nat: 3, p_local: 5, p_suburban: 2, p_int: 4, p_emerg: 1)
JfName.create(name: '金洲', ip_address: '192.166.16.13', status: 1, p_nat: 'nat', p_local: 'local', p_suburban: 'suburban', p_int: 'int', p_emerg: 'emerg')
JfName.create(name: '工业东', ip_address: '192.166.16.12', status: 1, p_nat: 'nat', p_local: 'local', p_suburban: 'suburban', p_int: 'int', p_emerg: 'emerg')
JfName.create(name: '汇接局', ip_address: '192.166.16.3', status: 1, p_nat: 'nat', p_local: 'local', p_suburban: 'suburban', p_int: 'int', p_emerg: 'emerg')
JfName.create(name: '东河', ip_address: '192.166.16.3', status: 1, p_nat: 'nat', p_local: 'local', p_suburban: 'suburban', p_int: 'int', p_emerg: 'emerg')
JfName.create(name: '十里亭', ip_address: '192.166.16.3', status: 1, p_nat: 'nat', p_local: 'local', p_suburban: 'suburban', p_int: 'int', p_emerg: 'emerg')
JfName.create(name: '始兴', ip_address: '192.166.16.9', status: 1, p_nat: 3, p_local: 1, p_suburban: 2, p_int: 4, p_emerg: 21)
JfName.create(name: '南雄', ip_address: '192.166.16.5', status: 1, p_nat: 'nat', p_local: 'local', p_suburban: 'suburban', p_int: 'int', p_emerg: 'emerg')
JfName.create(name: '坪石通信楼', ip_address: '192.166.16.16', status: 0)
JfName.create(name: '乐昌通信楼', ip_address: '192.166.16.14', status: 1, p_nat: 'nat', p_local: 'local', p_suburban: 'suburban', p_int: 'int', p_emerg: 'emerg')
JfName.create(name: '乐昌河南', ip_address: '192.166.16.15', status: 1, p_nat: 'nat', p_local: 'local', p_suburban: 'suburban', p_int: 'int', p_emerg: 'emerg')
JfName.create(name: '马坝中华园', ip_address: '192.166.16.7', status: 1, p_nat: 'nat', p_local: 'local', p_suburban: 'suburban', p_int: 'int', p_emerg: 'emerg')

#南郊
DnTable.create(jf_name_id: 1, dn_start: 6177500, dn_end: 6177999)
DnTable.create(jf_name_id: 1, dn_start: 6179000, dn_end: 6179999)
DnTable.create(jf_name_id: 1, dn_start: 6986000, dn_end: 6986499)
DnTable.create(jf_name_id: 1, dn_start: 6962000, dn_end: 6962299)
#南枫
DnTable.create(jf_name_id: 2, dn_start: 6187000, dn_end: 6189999)
DnTable.create(jf_name_id: 2, dn_start: 6968500, dn_end: 6968999)
DnTable.create(jf_name_id: 2, dn_start: 6985500, dn_end: 6985999)
#茗雅
DnTable.create(jf_name_id: 3, dn_start: 6106000, dn_end: 6106249)
DnTable.create(jf_name_id: 3, dn_start: 6106300, dn_end: 6106999)
DnTable.create(jf_name_id: 3, dn_start: 6107000, dn_end: 6109999)
DnTable.create(jf_name_id: 3, dn_start: 6116000, dn_end: 6116999)
DnTable.create(jf_name_id: 3, dn_start: 6118800, dn_end: 6118899)
DnTable.create(jf_name_id: 3, dn_start: 6990000, dn_end: 6990099)
DnTable.create(jf_name_id: 3, dn_start: 6993300, dn_end: 6993999)
DnTable.create(jf_name_id: 3, dn_start: 6123300, dn_end: 6123499)
DnTable.create(jf_name_id: 3, dn_start: 6918000, dn_end: 6918999)
#工业西
DnTable.create(jf_name_id: 4, dn_start: 6100000, dn_end: 6100999)
DnTable.create(jf_name_id: 4, dn_start: 6110000, dn_end: 6110999)
DnTable.create(jf_name_id: 4, dn_start: 6186000, dn_end: 6186999)
DnTable.create(jf_name_id: 4, dn_start: 6990550, dn_end: 6990999)
DnTable.create(jf_name_id: 4, dn_start: 6105000, dn_end: 6105499)
DnTable.create(jf_name_id: 4, dn_start: 6989200, dn_end: 6989999)
#金洲
DnTable.create(jf_name_id: 5, dn_start: 6181000, dn_end: 6185999)
DnTable.create(jf_name_id: 5, dn_start: 6111700, dn_end: 6111899)
DnTable.create(jf_name_id: 5, dn_start: 6981000, dn_end: 6982999)
DnTable.create(jf_name_id: 5, dn_start: 6900000, dn_end: 6900499)
#工业东
DnTable.create(jf_name_id: 6, dn_start: 6102000, dn_end: 6103999)
DnTable.create(jf_name_id: 6, dn_start: 6119000, dn_end: 6119999)
DnTable.create(jf_name_id: 6, dn_start: 6180000, dn_end: 6180999)
DnTable.create(jf_name_id: 6, dn_start: 6111000, dn_end: 6111699)
DnTable.create(jf_name_id: 6, dn_start: 6111900, dn_end: 6111999)
DnTable.create(jf_name_id: 6, dn_start: 6998000, dn_end: 6998899)
DnTable.create(jf_name_id: 6, dn_start: 6999900, dn_end: 6999999)
DnTable.create(jf_name_id: 6, dn_start: 6980000, dn_end: 6980999)
DnTable.create(jf_name_id: 6, dn_start: 6983000, dn_end: 6983999)
#汇接局
DnTable.create(jf_name_id: 7, dn_start: 6176000, dn_end: 6176999)
DnTable.create(jf_name_id: 7, dn_start: 6101000, dn_end: 6101999)
DnTable.create(jf_name_id: 7, dn_start: 6170000, dn_end: 6171999)
DnTable.create(jf_name_id: 7, dn_start: 6114000, dn_end: 6114999)
DnTable.create(jf_name_id: 7, dn_start: 6909000, dn_end: 6909199)
DnTable.create(jf_name_id: 7, dn_start: 6994950, dn_end: 6994959)
#东河
DnTable.create(jf_name_id: 8, dn_start: 6113000, dn_end: 6113999)
DnTable.create(jf_name_id: 8, dn_start: 6115000, dn_end: 6115999)
DnTable.create(jf_name_id: 8, dn_start: 6992000, dn_end: 6992999)
#十里亭
DnTable.create(jf_name_id: 9, dn_start: 6178000, dn_end: 6178499)
DnTable.create(jf_name_id: 9, dn_start: 6118000, dn_end: 6118799)
DnTable.create(jf_name_id: 9, dn_start: 6118900, dn_end: 6118999)
DnTable.create(jf_name_id: 9, dn_start: 6105500, dn_end: 6105999)
DnTable.create(jf_name_id: 9, dn_start: 6178800, dn_end: 6178999)
#始兴
DnTable.create(jf_name_id: 10, dn_start: 6130000, dn_end: 6133999)
#南雄
DnTable.create(jf_name_id: 11, dn_start: 6136000, dn_end: 6139999)
#坪石通信楼
DnTable.create(jf_name_id: 12, dn_start: 6155000, dn_end: 6159999)
DnTable.create(jf_name_id: 12, dn_start: 6150000, dn_end: 6150999)
#乐昌通信楼
DnTable.create(jf_name_id: 13, dn_start: 6160000, dn_end: 6160999)
DnTable.create(jf_name_id: 13, dn_start: 6165000, dn_end: 6169999)
#乐昌河南
DnTable.create(jf_name_id: 14, dn_start: 6161000, dn_end: 6164999)
#马坝中华园
DnTable.create(jf_name_id: 15, dn_start: 6190000, dn_end: 6193399)
DnTable.create(jf_name_id: 15, dn_start: 6193600, dn_end: 6193999)
DnTable.create(jf_name_id: 15, dn_start: 6195000, dn_end: 6195399)
DnTable.create(jf_name_id: 15, dn_start: 6195500, dn_end: 6197399)
DnTable.create(jf_name_id: 15, dn_start: 6197600, dn_end: 6197899)
DnTable.create(jf_name_id: 15, dn_start: 6197900, dn_end: 6197999)
DnTable.create(jf_name_id: 15, dn_start: 6198000, dn_end: 6198999)
DnTable.create(jf_name_id: 15, dn_start: 6960500, dn_end: 6960999)
DnTable.create(jf_name_id: 15, dn_start: 6961000, dn_end: 6961999)


