#!/usr/bin/env bash
# @author luchaoxin
# @version V 1.0
# @Description:
# @date 2021-03-21

# 登录任意一个mongos节点（如果是在上一步的窗口，需要退出重新登录）
script/bin/mongo --port 27017

use admin
db.auth('USER', 'PWD')

#添加分片
sh.addShard('shard1/IP_0:27181, IP_1:27281, IP_2:27381')
sh.addShard('shard2/IP_0:27182, IP_1:27282, IP_2:27382')
sh.addShard('shard3/IP_0:27183, IP_1:27283, IP_2:27383')

#查看分片状态
sh.status()