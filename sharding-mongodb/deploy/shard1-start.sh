#!/usr/bin/env bash
# @author luchaoxin
# @version V 1.0
# @Description:
# @date 2021-03-20
DATA_DIR="/opt/data/sharding-mongodb"
LOG_DIR="/opt/log/sharding-mongodb"

SHARD1_PORTS=('27181' '27281' '27381')
SHARD2_PORTS=('27182' '27282' '27382')
SHARD3_PORTS=('27183' '27283' '27383')

DATA_DIR_LIST=('pid' 'configsrv' 'socket')
SHARD_LIST=('shard1' 'shard2' 'shard3')
SOCKET_DIR_LIST=('configsrv' 'shard1' 'shard2' 'shard3' 'mongos')

function generate_shard_data_dir() {
  shard_name="shard1"

  prefix_dir="${DATA_DIR}/${shard_name:-shard1}"
  # /opt/data/sharding-mongodb/socket/shard1/27181
  for port in "${SHARD1_PORTS[@]}"; do
    DIR="${prefix_dir}/${port}"
    if [ ! -d "$DIR" ]; then
      echo "create socket directory: $DIR"
      echo "${PWD}" | sudo -S mkdir -p "$DIR"
    else
      echo "directory: ${DIR} already exists."
    fi
    
    socket_dir="${DATA_DIR}/socket/shard1/${port}"
    if [ ! -d "$socket_dir" ]; then
      echo "create socket directory: $socket_dir"
      echo "${PWD}" | sudo -S mkdir -p "$socket_dir"
    else
      echo "directory: ${socket_dir} already exists."
    fi
  done
}

function check_directory() {
  if [ ! -d "${LOG_DIR}" ]; then
    echo "create log directory: ${LOG_DIR}"
    echo "${PWD}" | sudo -S mkdir -p "${LOG_DIR}"
  else
    echo "log directory: ${LOG_DIR} already exists."
  fi

  generate_shard_data_dir

  for ITEM in "${DATA_DIR_LIST[@]}"; do
    DIR="${DATA_DIR}/${ITEM}"
    if [ ! -d "$DIR" ]; then
      echo "create data directory: $DIR"
      echo "${PWD}" | sudo -S mkdir -p "$DIR"
    else
      echo "directory: ${DIR} already exists."
    fi
  done

  # create socket directory
  for ITEM in "${SOCKET_DIR_LIST[@]}"; do
    DIR="${DATA_DIR}/socket/${ITEM}"

    if [ ! -d "$DIR" ]; then
      echo "create socket directory: $DIR"
      echo "${PWD}" | sudo -S mkdir -p "$DIR"
    else
      echo "directory: ${DIR} already exists."
    fi
  done

  echo "change directory owner to $USER:$USER"
  echo "${PWD}" | sudo -S chown -R $USER:$USER "${DATA_DIR}"
}

check_directory

for port in "${SHARD1_PORTS[@]}"; do
  script/bin/mongod -f "shard1-${port}.conf"
done

