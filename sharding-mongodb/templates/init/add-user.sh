#!/usr/bin/env bash
# @author luchaoxin
# @version V 1.0
# @Description:
# @date 2021-03-21

#登录主节点
script/bin/mongo --port 27181

use admin
db.createUser({
  user: 'USER',
  pwd: 'PWD',
  roles: [ { role: 'root', db: 'admin' } ]
})