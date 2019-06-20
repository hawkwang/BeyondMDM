FROM anapsix/alpine-java:8_server-jre_unlimited

MAINTAINER wangiegie@gmail.com

RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

RUN mkdir -p /pigx-config

WORKDIR /pigx-config

EXPOSE 8888

ADD ./pigx-config/target/pigx-config.jar ./

CMD java -Djava.security.egd=file:/dev/./urandom -jar pigx-config.jar
