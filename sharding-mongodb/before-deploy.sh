#!/usr/bin/env bash
# @author luchaoxin
# @version V 1.0
# @Description:
# @date 2021-03-20

DATA_DIR='/opt/data/sharding-mongodb'
LOG_DIR='/opt/log/sharding-mongodb'

IP_ADDRESSES=('172.18.169.113' '172.18.169.113' '172.18.169.103')
USER='pistonint'
PWD='root!2021.12#'

SHARD1_PORTS=('27181' '27281' '27381')
SHARD2_PORTS=('27182' '27282' '27382')
SHARD3_PORTS=('27183' '27283' '27383')

SHARD_NAMES=('shard1' 'shard2' 'shard3')
mac_os_name='Darwin'

function generate_key_file() {
  keyfile="${DATA_DIR}/auth/keyfile.key"
  if [ ! -f "$keyfile" ]; then
    echo "create $keyfile"
    mkdir -p "${DATA_DIR}/auth"
    openssl rand -base64 756 -out "$keyfile"
    echo "${PWD}" | sudo -S chmod 400 "$keyfile"
    echo "${PWD}" | sudo -S chown 999 "$keyfile"
  else
    echo "$keyfile already exists."
  fi
}

function generate_shard_conf() {
  shard_name=$1
  port=$2
  file_name="deploy/${shard_name}-${port}.conf"
  echo "$file_name"
  cp "deploy/shard-conf.template" "$file_name"

  if [ "$(uname)" == "${mac_os_name}" ]; then
    sed -i '' "s/PORT/${port}/g" "$file_name"
    sed -i '' "s/SHARD_NAME/${shard_name}/g" "$file_name"
  else
    sed -i "s/PORT/${port}/g" "$file_name"
    sed -i "s/SHARD_NAME/${shard_name}/g" "$file_name"
  fi
  sudo chmod 777 "$file_name"
}

function try_generate_shard_conf() {

  if [ "$1" == "shard-conf.template" ]; then
    for port in "${SHARD1_PORTS[@]}"; do
      generate_shard_conf "shard1" "$port"
    done

    for port in "${SHARD2_PORTS[@]}"; do
      generate_shard_conf "shard2" "$port"
    done

    for port in "${SHARD3_PORTS[@]}"; do
      generate_shard_conf "shard3" "$port"
    done
    rm "deploy/shard-conf.template"
  fi
}

function generate_shard_start_script() {
    shard_name=$1
    new_file="deploy/${shard_name}-start.sh"
    cp "templates/init/shard-start.sh" "$new_file"

    if [ "$shard_name" == "shard1" ]; then
      SHARD_PORTS="SHARD1_PORTS"
    fi

    if [ "$shard_name" == "shard2" ]; then
      SHARD_PORTS="SHARD2_PORTS"
    fi

    if [ "$shard_name" == "shard3" ]; then
      SHARD_PORTS="SHARD3_PORTS"
    fi

    if [ "$(uname)" == "${mac_os_name}" ]; then
        sed -i '' "s/SHARD_PORTS/${SHARD_PORTS}/g" "${new_file}"
        sed -i '' "s/SHARD_NAME/${shard_name}/g" "${new_file}"
        sed -i '' "s/DATA_DIR_VAL/${DATA_DIR//\//\\/}/g" "${new_file}"
        sed -i '' "s/LOG_DIR_VAL/${LOG_DIR//\//\\/}/g" "${new_file}"
      else
        sed -i "s/SHARD_PORTS/${SHARD_PORTS}/g" "${new_file}"
        sed -i "s/SHARD_NAME/${shard_name}/g" "${new_file}"
      sed -i "s/DATA_DIR_VAL/${DATA_DIR//\//\\/}/g" "${new_file}"
      sed -i "s/LOG_DIR_VAL/${LOG_DIR//\//\\/}/g" "${new_file}"
    fi
    sudo chmod 777 "${new_file}"
}

function generate_init_conf() {
  for file in $(ls templates/init); do
    new_file="deploy/$file"
    cp "templates/init/$file" "$new_file"
    sudo chmod 777 "$new_file"

    for i in "${!IP_ADDRESSES[@]}"; do
      ip="${IP_ADDRESSES[$i]}"
      if [ "$(uname)" == "${mac_os_name}" ]; then
        sed -i '' "s/IP_$i/${ip}/g" "${new_file}"
        sed -i '' "s/USER/${USER}/g" "${new_file}"
        sed -i '' "s/PWD/${PWD}/g" "${new_file}"
      else
        sed -i "s/IP_$i/${ip}/g" "${new_file}"
        sed -i "s/USER/${USER}/g" "${new_file}"
        sed -i "s/PWD/${PWD}/g" "${new_file}"
      fi

      if [ "$file" == "shard-start.sh" ]; then
        for i in "${!SHARD_NAMES[@]}"; do
          shard_name="${SHARD_NAMES[$i]}"
          generate_shard_start_script "$shard_name"
        done
      fi
    done
  done
}

function generate_conf() {
  if [ ! -d 'deploy' ]; then
    mkdir 'deploy'
  fi
  for file in $(ls templates/conf); do
    new_file="deploy/$file"
    cp "templates/conf/$file" "$new_file"
    sudo chmod 777 "$new_file"

    if [ "$(uname)" == "${mac_os_name}" ]; then
      sed -i '' "s/DATA_DIR/${DATA_DIR//\//\\/}/g" "${new_file}"
      sed -i '' "s/LOG_DIR/${LOG_DIR//\//\\/}/g" "${new_file}"
    else
      sed -i "s/DATA_DIR/${DATA_DIR//\//\\/}/g" "${new_file}"
      sed -i "s/LOG_DIR/${LOG_DIR//\//\\/}/g" "${new_file}"
    fi
    try_generate_shard_conf "$file"
  done
  generate_init_conf

  if [ -f 'deploy/shard-start.sh' ]; then
    rm "deploy/shard-start.sh"
  fi
}

#check_directory
#generate_key_file
generate_conf