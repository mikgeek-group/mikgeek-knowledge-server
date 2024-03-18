FROM anapsix/alpine-java:8_server-jre_unlimited

MAINTAINER Lion Li

RUN mkdir -p /mikgeek/sentinel-dashboard/logs \
    /mikgeek/skywalking/agent

WORKDIR /mikgeek/sentinel-dashboard

EXPOSE 8718

ADD ./target/mikgeek-sentinel-dashboard.jar ./app.jar

ENTRYPOINT ["java", \
            "-Djava.security.egd=file:/dev/./urandom", \
#            "-Dskywalking.agent.service_name=mikgeek-sentinel-dashboard", \
#            "-javaagent:/mikgeek/skywalking/agent/skywalking-agent.jar", \
            "-jar", "app.jar"]
