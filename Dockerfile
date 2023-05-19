FROM debian:buster-slim AS dl

ENV MC_VER=1.20-pre4

WORKDIR /tmp

RUN apt update &&\
    apt install wget -y -qq &&\
    wget $(wget -qO- "https://mcversions.net/download/$MC_VER" | grep -o https://piston-data.mojang.com/v1/objects/.*/server.jar) -O server.jar

FROM azul/zulu-openjdk:19-jre

ENV MEM_ALLOCATION=6G

EXPOSE 25565

WORKDIR /opt/mc

COPY --from=dl /tmp/server.jar .
COPY . .
RUN chmod +x entrypoint.sh

WORKDIR /opt/mc/server

ENTRYPOINT [ "/bin/bash", "/opt/mc/entrypoint.sh" ]
