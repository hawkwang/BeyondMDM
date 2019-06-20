FROM anapsix/alpine-java:8_server-jre_unlimited

MAINTAINER wangiegie@gmail.com

RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

RUN mkdir -p /pigx-zipkin

WORKDIR /pigx-zipkin

EXPOSE 5006

ADD ./pigx-visual/pigx-zipkin/target/pigx-zipkin.jar ./

CMD java -Djava.security.egd=file:/dev/./urandom -jar pigx-zipkin.jar
