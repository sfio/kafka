#!/usr/bin/env sh
set -e

while netstat -lnt | awk '$4 ~ /:'9092'$/ {exit 1}'; do
    echo "waiting for kafka to be ready"
    sleep 1
done

/kafka/bin/kafka-topics.sh --zookeeper localhost:2181 --create --replication-factor 1 --partitions 1 --topic input
/kafka/bin/kafka-topics.sh --zookeeper localhost:2181 --create --replication-factor 1 --partitions 1 --topic output
/kafka/bin/kafka-topics.sh --zookeeper localhost:2181 --create --replication-factor 1 --partitions 1 --topic notify
