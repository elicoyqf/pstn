#encoding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

JfName.create(name: '南郊', ip_address: '192.166.16.11', status: 1)
JfName.create(name: '南枫', ip_address: '192.166.16.8', status: 0)
JfName.create(name: '茗雅', ip_address: '192.166.16.4', status: 1)
JfName.create(name: '工业西', ip_address: '192.166.16.10', status: 1)
JfName.create(name: '金洲', ip_address: '192.166.16.13', status: 1)
JfName.create(name: '工业东', ip_address: '192.166.16.12', status: 1)
JfName.create(name: '汇接局', ip_address: '192.166.16.3', status: 1)
JfName.create(name: '东河', ip_address: '192.166.16.3', status: 1)
JfName.create(name: '十里亭', ip_address: '192.166.16.3', status: 1)
JfName.create(name: '始兴', ip_address: '192.166.16.9', status: 1)
JfName.create(name: '南雄', ip_address: '192.166.16.5', status: 1)
JfName.create(name: '坪石通信楼', ip_address: '192.166.16.16', status: 0)
JfName.create(name: '乐昌通信楼', ip_address: '192.166.16.14', status: 1)
JfName.create(name: '乐昌河南', ip_address: '192.166.16.15', status: 1)
JfName.create(name: '马坝中华园', ip_address: '192.166.16.7', status: 1)

DnTable.create(jf_name_id:1,dn_start:'6177500',dn_end:'6177999')
DnTable.create(jf_name_id:1,dn_start:'6179000',dn_end:'6179999')
DnTable.create(jf_name_id:1,dn_start:'6986000',dn_end:'6986999')
DnTable.create(jf_name_id:1,dn_start:'6962000',dn_end:'6962999')



