#!/usr/bin/env sh
set -e

## defaults
LISTENER=kafka
PORT=9092

## parse params
for i in $@; do
	case $i in -listener=*)
		LISTENER="${i#-listener=}"
	esac
	case $i in -port=*)
		PORT="${i#-port=}"
	esac
	case $i in -silent)
		SILENT=1
	esac
done

KAFKA_PROPS=/kafka/config/server.properties
echo >> $KAFKA_PROPS

## set connection properties
echo "listeners=PLAINTEXT://:$PORT" >> $KAFKA_PROPS
echo "advertised.listeners=PLAINTEXT://$LISTENER:$PORT" >> $KAFKA_PROPS

## speedup shutdown
echo "controlled.shutdown.enable=false" >> $KAFKA_PROPS

## decrease verbosity
if [ "$SILENT" ]; then
	LOG4J_PROPS=/kafka/config/log4j.properties
	echo "log4j.rootLogger=WARN, stdout" >> $LOG4J_PROPS
	echo "log4j.logger.kafka=WARN" >> $LOG4J_PROPS
	echo "log4j.logger.org.apache.kafka=WARN" >> $LOG4J_PROPS
	echo "log4j.logger.org.apache.zookeeper=WARN" >> $LOG4J_PROPS
	echo "log4j.logger.org.I0Itec.zkclient.ZkClient=WARN" >> $LOG4J_PROPS
fi

## daemonize zookepeer
/zk/bin/zkServer.sh start

## start Kafka
exec /kafka/bin/kafka-server-start.sh $KAFKA_PROPS
