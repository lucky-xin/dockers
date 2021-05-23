#!/usr/bin/env bash
# @author luchaoxin
# @version V 1.0
# @Description:
# @date 2021-03-20

#登录主节点
script/bin/mongo --port 27181
#使用admin数据库
use admin
#定义副本集配置
config = {
    _id : 'shard1',
    members : [
         {_id : 0, host : 'IP_0:27181'},
         {_id : 1, host : 'IP_1:27281', arbiterOnly: true},
         {_id : 2, host : 'IP_2:27381'}
    ]
}
#初始化副本集配置
rs.initiate(config)

#--------------------------------
script/bin/mongo --port 27282
#使用admin数据库
use admin
#定义副本集配置
config = {
    _id : 'shard2',
    members : [
         {_id : 0, host : 'IP_0:27182'},
         {_id : 1, host : 'IP_1:27282'},
         {_id : 2, host : 'IP_2:27382', arbiterOnly: true}
    ]
}
#初始化副本集配置
rs.initiate(config)

#--------------------------------
script/bin/mongo --port 27383
#使用admin数据库
use admin
#定义副本集配置
config = {
    _id : 'shard3',
    members : [
         {_id : 0, host : 'IP_0:27183', arbiterOnly: true},
         {_id : 1, host : 'IP_1:27283'},
         {_id : 2, host : 'IP_2:27383'}
    ]
}

#初始化副本集配置
rs.initiate(config)
