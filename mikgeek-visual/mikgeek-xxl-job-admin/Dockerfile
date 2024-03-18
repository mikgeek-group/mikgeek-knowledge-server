FROM anapsix/alpine-java:8_server-jre_unlimited

MAINTAINER Lion Li

RUN mkdir -p /mikgeek/xxl-job-admin/logs \
    /mikgeek/skywalking/agent

WORKDIR /mikgeek/xxl-job-admin

ENV TZ=PRC
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

EXPOSE 9900

ADD ./target/mikgeek-xxl-job-admin.jar ./app.jar

ENTRYPOINT ["java", \
            "-Djava.security.egd=file:/dev/./urandom", \
#            "-Dskywalking.agent.service_name=mikgeek-xxl-job-admin", \
#            "-javaagent:/mikgeek/skywalking/agent/skywalking-agent.jar", \
            "-jar", "app.jar"]
