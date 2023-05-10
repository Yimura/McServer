FROM debian:buster-slim AS dl

WORKDIR /tmp

RUN apt update && apt install wget -y && wget https://piston-data.mojang.com/v1/objects/95ac4bf3d2f4ae57687493f5232d3f58334b85d2/server.jar -O server.jar

FROM azul/zulu-openjdk:19-jre

EXPOSE 25565

WORKDIR /opt/mc

COPY --from=dl /tmp/server.jar .
COPY . .
RUN chmod +x entrypoint.sh

WORKDIR /opt/mc/server

ENTRYPOINT [ "/bin/bash", "/opt/mc/entrypoint.sh" ]
