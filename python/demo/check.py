#-*- coding:utf-8 -*-

import pymysql
import os
result = os.popen('docker exec ceph_mon rbd ls volumes')
res = result.read()
#print res

#连接数据库
connection=pymysql.connect(db='cinder', user='cinder', password='RainTygTzOQnudyILewv4qfc6nO0NvLIVQSMNHPk', host='172.19.59.8', port=3306,charset='utf8')
#通过cursor创建游标
cursor=connection.cursor()
#执行数据查询
cursor.execute("select id from volumes where status = 'deleted'")
#cursor.execute("select id from volumes where status = 'available' limit 10")
#查询多条数据
result=cursor.fetchall()
for data in result:
    data = "volume-%s" %data
    if res.find(data) >=0:
      print('find error<<<<<<<<')
      print(data)
      os.popen('echo %s >> error.txt' %data)
      print('>>>>>>>>')
    else:
      print("%s is passed " %data)

#关闭数据连接
connection.close()

