FROM zookeeper:3.8.0

ENV ZOO_MY_ID=1
ENV ZOO_SERVERS=server.1=zookeeper:2888:3888
ENV ZOOKEEPER_CLIENT_PORT=2181

RUN mkdir -p /data /datalog

EXPOSE 2181 2888 3888

CMD ["zkServer.sh", "start-foreground"]
