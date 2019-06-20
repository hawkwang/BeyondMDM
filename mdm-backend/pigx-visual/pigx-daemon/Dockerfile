FROM anapsix/alpine-java:8_server-jre_unlimited

MAINTAINER wangiegie@gmail.com

RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

RUN mkdir -p /pigx-daemon

WORKDIR /pigx-daemon

EXPOSE 5002

ADD ./pigx-visual/pigx-daemon/target/pigx-daemon.jar ./

CMD java -Djava.security.egd=file:/dev/./urandom -jar pigx-daemon.jar
