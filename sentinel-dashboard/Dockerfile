# @author Luchaoxin
# @version V 1.0
#  构建springboot项目镜像通用Dockerfile
ARG BASE_IMAGE=openjdk:8-jre-alpine
FROM ${BASE_IMAGE}

LABEL maintainer="chaoxin.lu@pistonint.com"

ARG SERVER_IP
ARG SERVER_PORT
ARG TZ
ARG JAR_FILE

ENV SERVER_IP ${SERVER_IP:-127.0.0.1}
ENV SERVER_PORT ${SERVER_PORT:-8888}
ENV JAR_FILE ${JAR_FILE}
ENV HEAP_SIZE ${HEAP_SIZE:-256M}
ENV LOG_DIR ${LOG_DIR:-/var/log/pistonint/sentinel-dashboard}
ENV TZ ${TZ:-Asia/Shanghai}
ENV MAX_GC_PAUSE_MILLIS ${MAX_GC_PAUSE_MILLIS:-200}
ENV AUTH_USER ${AUTH_USER:-pistonint.cloud}
ENV AUTH_PWD ${AUTH_PWD:-pi@st!oni$.i.cl1202ou!dds@!}

RUN ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo '${TZ}' > /etc/timezone \
    && mkdir -p /sentinel-dashboard \
    && mkdir -p ${LOG_DIR}

WORKDIR /sentinel

EXPOSE ${SERVER_PORT}

ADD ./${JAR_FILE} ./

ENTRYPOINT sleep 10;java -Djava.security.egd=file:/dev/./urandom ${JAVA_OPTS:--Xms${HEAP_SIZE} \
    -Xmx${HEAP_SIZE} \
    -Xss256k -XX:+UseG1GC \
    -XX:MaxGCPauseMillis=${MAX_GC_PAUSE_MILLIS} \
    -XX:+HeapDumpOnOutOfMemoryError \
    -XX:HeapDumpPath=${LOG_DIR}/heapdump.txt \
    -Xloggc:${LOG_DIR}/gc.log \
    -Dproject.name=sentinel-dashboard \
    -Dcsp.sentinel.dashboard.server=${SERVER_IP}:${SERVER_PORT} \
    -Dserver.port=${SERVER_PORT} \
    -Dcsp.sentinel.api.port=8719 \
    -Dsentinel.dashboard.auth.username=${AUTH_USER} \
    -Dsentinel.dashboard.auth.password=${AUTH_PWD} \
    -jar ${JAR_FILE}}