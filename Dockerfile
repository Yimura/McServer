FROM debian:buster-slim AS dl

WORKDIR /tmp

RUN apt update && apt install wget -y && wget https://piston-data.mojang.com/v1/objects/4a8487f877eb4f3506978fb85faf41a08b570398/server.jar -O server.jar

FROM azul/zulu-openjdk:19-jre

EXPOSE 25565

WORKDIR /opt/mc

COPY --from=dl /tmp/server.jar .
COPY . .
RUN chmod +x entrypoint.sh

WORKDIR /opt/mc/server

ENTRYPOINT [ "/bin/bash", "/opt/mc/entrypoint.sh" ]