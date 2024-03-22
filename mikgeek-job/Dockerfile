FROM anapsix/alpine-java:8_server-jre_unlimited

MAINTAINER Lion Li

RUN mkdir -p /mikgeek/job/logs \
    /mikgeek/job/temp \
    /mikgeek/skywalking/agent

WORKDIR /mikgeek/job

ENV SERVER_PORT=9203

EXPOSE ${SERVER_PORT}

ADD ./target/mikgeek-job.jar ./app.jar

ENTRYPOINT ["java", \
            "-Djava.security.egd=file:/dev/./urandom", \
            "-Dserver.port=${SERVER_PORT}", \
#            "-Dskywalking.agent.service_name=mikgeek-job", \
#            "-javaagent:/mikgeek/skywalking/agent/skywalking-agent.jar", \
            "-jar", "app.jar"]
