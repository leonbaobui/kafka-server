FROM wurstmeister/kafka:latest

ENV KAFKA_ADVERTISED_LISTENERS=PLAINTEXT://kafka-8ohm.onrender.com:9092
ENV KAFKA_LISTENERS=PLAINTEXT://0.0.0.0:9092
ENV KAFKA_ZOOKEEPER_CONNECT=zookeeper-o4w6.onrender.com:45643
ENV KAFKA_BROKER_ID=1

EXPOSE 9092

CMD ["kafka-server-start.sh", "/opt/kafka/config/server.properties"]