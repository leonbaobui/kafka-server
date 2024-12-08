#!/bin/bash

BROKER_ID=${BROKER_ID:-1}
KAFKA_ADVERTISED_LISTENERS=${KAFKA_ADVERTISED_LISTENERS:-PLAINTEXT://${HOSTNAME}:9092}

# Generate the KRaft configuration
KAFKA_CONFIG_FILE="/opt/kafka/config/kraft/server.properties"

cat <<EOL > $KAFKA_CONFIG_FILE
process.roles=broker
node.id=${BROKER_ID}
log.dirs=/opt/kafka/data
advertised.listeners=${KAFKA_ADVERTISED_LISTENERS}
listeners=PLAINTEXT://0.0.0.0:9092
num.network.threads=3
num.io.threads=8
log.retention.hours=168
log.segment.bytes=1073741824
log.retention.check.interval.ms=300000
offsets.topic.replication.factor=1
transaction.state.log.replication.factor=1
transaction.state.log.min.isr=1
EOL

# Format the KRaft storage (if necessary)
if [ ! -f /opt/kafka/data/meta.properties ]; then
    echo "Formatting storage directory..."
    /opt/kafka/bin/kafka-storage.sh format --config $KAFKA_CONFIG_FILE --cluster-id $(/opt/kafka/bin/kafka-storage.sh random-uuid)
fi

# Start Kafka
/opt/kafka/bin/kafka-server-start.sh $KAFKA_CONFIG_FILE
