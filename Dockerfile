FROM debian:buster-slim AS dl

ENV SERVER_JAR_URL=https://piston-data.mojang.com/v1/objects/04b889e29aeffc23d2a3ebdd7e728184d9441e02/server.jar

WORKDIR /tmp

RUN apt update && apt install wget -y && wget ${SERVER_JAR_URL} -O server.jar

FROM azul/zulu-openjdk:19-jre

ENV MEM_ALLOCATION=6G

EXPOSE 25565

WORKDIR /opt/mc

COPY --from=dl /tmp/server.jar .
COPY . .
RUN chmod +x entrypoint.sh

WORKDIR /opt/mc/server

ENTRYPOINT [ "/bin/bash", "/opt/mc/entrypoint.sh" ]
