FROM mysql:5.7

MAINTAINER lengleng(wangiegie@gmail.com)

RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

COPY ./db/1schema.sql /docker-entrypoint-initdb.d

COPY ./db/2pigxx.sql /docker-entrypoint-initdb.d

COPY ./db/3pigxx_ac.sql /docker-entrypoint-initdb.d

COPY ./db/4pigxx_zipkin.sql /docker-entrypoint-initdb.d