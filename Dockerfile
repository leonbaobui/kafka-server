FROM wurstmeister/kafka:latest

ENV KAFKA_ADVERTISED_LISTENERS=PLAINTEXT://kafka-8ohm.onrender.com:9092
ENV KAFKA_LISTENERS=PLAINTEXT://0.0.0.0:9092
ENV KAFKA_ZOOKEEPER_CONNECT=kafka-server-tjn5.onrender.com
ENV KAFKA_BROKER_ID=1

EXPOSE 9092

CMD ["kafka-server-start.sh", "/opt/kafka/config/server.properties"]