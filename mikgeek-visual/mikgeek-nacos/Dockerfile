FROM openjdk:8u201-jre-alpine

MAINTAINER Lion Li

RUN mkdir -p /mikgeek/nacos

WORKDIR /mikgeek/nacos

EXPOSE 8848

ENV TZ=Asia/Shanghai JAVA_OPTS="-Xms256m -Xmx512m"

ADD ./target/mikgeek-nacos.jar ./app.jar

ENTRYPOINT ["java", "-Djava.security.egd=file:/dev/./urandom", "-jar", "app.jar", "${JAVA_OPTS}"]

