FROM debian:8

RUN apt-get update && apt-get upgrade -y
RUN apt-get install bzip2 -y

ADD http://dl.4players.de/ts/releases/3.0.12.2/teamspeak3-server_linux_amd64-3.0.12.2.tar.bz2 .

RUN tar jxf teamspeak3-server_linux_amd64-3.0.12.2.tar.bz2
RUN mv teamspeak3-server_linux_amd64 teamspeak
RUN rm teamspeak3-server_linux_amd64-3.0.12.2.tar.bz2

# Create teamspeak user
RUN useradd -s /usr/sbin/nologin teamspeak

RUN mkdir -p /data/logs
RUN chown -R teamspeak:teamspeak /data

USER teamspeak
WORKDIR /data

ENV LD_LIBRARY_PATH="/teamspeak:${LD_LIBRARY_PATH}"

VOLUME ["/data"]
CMD ["/teamspeak/ts3server", "logpath=/data/logs/", "dbsqlpath=/teamspeak/sql/"]
