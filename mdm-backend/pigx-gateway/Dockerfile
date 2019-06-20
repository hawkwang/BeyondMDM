FROM anapsix/alpine-java:8_server-jre_unlimited

MAINTAINER wangiegie@gmail.com

RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

RUN mkdir -p /pigx-gateway

WORKDIR /pigx-gateway

EXPOSE 9999

ADD ./pigx-gateway/target/pigx-gateway.jar ./

CMD java -Djava.security.egd=file:/dev/./urandom -jar pigx-gateway.jar
