FROM openjdk:11-jre-slim

# Set environment variables for Kafka version
ENV KAFKA_VERSION=3.7.1 \
    SCALA_VERSION=2.12

# Download and extract Kafka binaries
RUN apt-get update && apt-get install -y wget \
    && wget https://downloads.apache.org/kafka/${KAFKA_VERSION}/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz \
    && tar -xzf kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz -C /opt \
    && mv /opt/kafka_${SCALA_VERSION}-${KAFKA_VERSION} /opt/kafka \
    && rm kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz

# Set up Kafka and Zookeeper data directories
RUN mkdir -p /opt/kafka/data /opt/kafka/logs

# Expose necessary ports
EXPOSE 9092 2181

# Add entrypoint script
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# Set the working directory
WORKDIR /opt/kafka

# Command to start Kafka and Zookeeper
ENTRYPOINT ["docker-entrypoint.sh"]
