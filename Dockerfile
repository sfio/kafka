FROM alpine:3.8

RUN apk add --no-cache bash curl openjdk8-jre-base

RUN curl http://www-us.apache.org/dist/zookeeper/zookeeper-3.4.13/zookeeper-3.4.13.tar.gz | tar xz &&\
	mv zookeeper-3.4.13 /zk &&\
	rm -rf /zk/bin/*.cmd /zk/contrib /zk/dist-maven /zk/docs /zk/src &&\
	mv /zk/conf/zoo_sample.cfg /zk/conf/zoo.cfg &&\
	curl http://www-us.apache.org/dist/kafka/1.1.1/kafka_2.11-1.1.1.tgz | tar xz &&\
	mv kafka_2.11-1.1.1 /kafka &&\
	rm -rf /kafka/site-docs /kafka/bin/windows &&\
	chown -R root:root /zk && chmod -R g=u /kafka /zk

USER 1000
COPY entry.sh /
ENTRYPOINT ["/entry.sh"]
