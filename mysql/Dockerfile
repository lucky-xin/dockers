FROM mysql:8.0.25

LABEL maintainer="chaoxin.lu@pistonint.com"

ENV TZ ${TZ:-Asia/Shanghai}

RUN ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo '${TZ}' > /etc/timezone

COPY ./initdb.d/1schema.sql /docker-entrypoint-initdb.d

COPY ./initdb.d/2pistonint_cloud.sql /docker-entrypoint-initdb.d

COPY ./initdb.d/3pistonint_cloud_config.sql /docker-entrypoint-initdb.d

COPY ./initdb.d/4pistonint_cloud_job.sql /docker-entrypoint-initdb.d