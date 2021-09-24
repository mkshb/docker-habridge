FROM openjdk:8-alpine

RUN mkdir -p /opt/echobridge 
WORKDIR /opt/echobridge
RUN apk --no-cache add curl
RUN curl -L https://github.com/bwssytems/ha-bridge/releases/download/v5.4.1RC1/ha-bridge-5.4.1RC1.jar --output ha-bridge.jar

EXPOSE 81

HEALTHCHECK --interval=1m --timeout=2s CMD curl -LSs http://localhost:81 || exit 1

CMD java -jar -Dserver.port=81 -Dconfig.file=/opt/echobridge/data/habridge.config /opt/echobridge/ha-bridge.jar
