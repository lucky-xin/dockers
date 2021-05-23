# @author Luchaoxin
# @version V 1.0
FROM camunda/camunda-bpm-platform

LABEL maintainer="chaoxin.lu@pistonint.com"

ARG VERSION
ARG TZ

ENV TZ ${TZ:-Asia/Shanghai}
ENV VERSION ${VERSION}

#COPY ./apps/demo /camunda/webapps/demo