FROM anapsix/alpine-java:8_server-jre_unlimited

MAINTAINER Lion Li

RUN mkdir -p /mikgeek/auth/logs  \
    /mikgeek/auth/temp  \
    /mikgeek/skywalking/agent

WORKDIR /mikgeek/auth

ENV SERVER_PORT=9210

EXPOSE ${SERVER_PORT}

ADD ./target/mikgeek-auth.jar ./app.jar

ENTRYPOINT ["java", \
            "-Djava.security.egd=file:/dev/./urandom", \
            "-Dserver.port=${SERVER_PORT}", \
#            "-Dskywalking.agent.service_name=mikgeek-auth", \
#            "-javaagent:/mikgeek/skywalking/agent/skywalking-agent.jar", \
            "-jar", "app.jar"]
