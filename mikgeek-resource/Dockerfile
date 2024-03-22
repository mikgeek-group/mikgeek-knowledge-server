FROM anapsix/alpine-java:8_server-jre_unlimited

MAINTAINER Lion Li

RUN mkdir -p /mikgeek/resource/logs \
    /mikgeek/resource/temp \
    /mikgeek/skywalking/agent

WORKDIR /mikgeek/resource

ENV SERVER_PORT=9204

EXPOSE ${SERVER_PORT}

ADD ./target/mikgeek-resource.jar ./app.jar

ENTRYPOINT ["java", \
            "-Djava.security.egd=file:/dev/./urandom", \
            "-Dserver.port=${SERVER_PORT}", \
#            "-Dskywalking.agent.service_name=mikgeek-resource", \
#            "-javaagent:/mikgeek/skywalking/agent/skywalking-agent.jar", \
            "-jar", "app.jar"]
