FROM anapsix/alpine-java:8_server-jre_unlimited

MAINTAINER Lion Li

RUN mkdir -p /mikgeek/knowledge/logs \
    /mikgeek/knowledge/temp \
    /mikgeek/skywalking/agent

WORKDIR /mikgeek/knowledge

ENV SERVER_PORT=9209

EXPOSE ${SERVER_PORT}

ADD ./target/mikgeek-system.jar ./app.jar

ENTRYPOINT ["java", \
            "-Djava.security.egd=file:/dev/./urandom", \
            "-Dserver.port=${SERVER_PORT}", \
#            "-Dskywalking.agent.service_name=mikgeek-system", \
#            "-javaagent:/mikgeek/skywalking/agent/skywalking-agent.jar", \
            "-jar", "app.jar"]
