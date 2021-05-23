#!/usr/bin/env bash
# @author luchaoxin
# @version V 1.0
# @Description:
# @date 2021-03-21

script/bin/mongo --port 27019

#配置集群
config = {
  _id : 'configsvr_rs',
  members : [
  {_id : 0, host : 'IP_0:27019'},
  {_id : 1, host : 'IP_1:27019'},
  {_id : 2, host : 'IP_2:27019'}
  ]
}

#初始化集群
rs.initiate(config)

