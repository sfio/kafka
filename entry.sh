#!/usr/bin/env sh
set -e

## set essential Kafka properties
KAFKA_PROPS=/kafka/config/server.properties
echo >> $KAFKA_PROPS
echo "listeners=PLAINTEXT://:9092" >> $KAFKA_PROPS
echo "advertised.listeners=PLAINTEXT://kafka:9092" >> $KAFKA_PROPS

## set Kafka log level to WARN
#LOG4J_PROPS=/kafka/config/log4j.properties
#echo "log4j.rootLogger=WARN, stdout" >> $LOG4J_PROPS
#echo "log4j.logger.kafka=WARN" >> $LOG4J_PROPS
#echo "log4j.logger.org.apache.kafka=WARN" >> $LOG4J_PROPS
#echo "log4j.logger.org.apache.zookeeper=WARN" >> $LOG4J_PROPS
#echo "log4j.logger.org.I0Itec.zkclient.ZkClient=WARN" >> $LOG4J_PROPS

## daemonize zookepeer
/zk/bin/zkServer.sh start

## start Kafka
exec /kafka/bin/kafka-server-start.sh $KAFKA_PROPS
