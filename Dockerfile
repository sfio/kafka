FROM alpine:3.8

## Install custom busybox and other deps
ADD https://fastscore.ai/alpine/v3.8/busybox-1.28.4-r1.apk /
RUN apk --allow-untrusted add busybox-1.28.4-r1.apk && rm busybox-1.28.4-r1.apk &&\
	apk add --no-cache bash curl openjdk8-jre-base

## Get Zookeeper and Kafka
RUN curl http://www-us.apache.org/dist/zookeeper/zookeeper-3.4.13/zookeeper-3.4.13.tar.gz | tar xz &&\
	mv zookeeper-3.4.13 /zk &&\
	rm -rf /zk/bin/*.cmd /zk/contrib /zk/dist-maven /zk/docs /zk/src &&\
	mv /zk/conf/zoo_sample.cfg /zk/conf/zoo.cfg &&\
	curl http://www-us.apache.org/dist/kafka/1.1.1/kafka_2.11-1.1.1.tgz | tar xz &&\
	mv kafka_2.11-1.1.1 /kafka &&\
	rm -rf /kafka/site-docs /kafka/bin/windows &&\
	chown -R root:root /zk && chmod -R g=u /kafka /zk

## Default user
USER 1000

## Entrypoint
COPY entry.sh /
ENTRYPOINT ["/entry.sh"]
