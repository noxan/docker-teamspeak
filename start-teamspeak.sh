#!/bin/sh

docker rm teamspeak-data

docker inspect teamspeak-data > /dev/null 2>&1 || docker run --name teamspeak-data noxan/teamspeak /bin/echo "Data-only container for TeamSpeak"

docker run --name teamspeak --detach --publish 9987:9987/udp --publish 10011:10011 --publish 30033:30033 --volumes-from teamspeak-data noxan/teamspeak
