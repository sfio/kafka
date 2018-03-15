FROM alpine

RUN apk add --no-cache bash curl openjdk8-jre-base

RUN curl http://www-us.apache.org/dist/zookeeper/zookeeper-3.4.11/zookeeper-3.4.11.tar.gz | tar xz &&\
	mv zookeeper-3.4.11 /zk &&\
	rm -rf /zk/contrib /zk/dist-maven /zk/docs /zk/src &&\
	mv /zk/conf/zoo_sample.cfg /zk/conf/zoo.cfg

RUN curl http://www-us.apache.org/dist/kafka/1.0.1/kafka_2.11-1.0.1.tgz | tar xz &&\
	mv kafka_2.11-1.0.1 /kafka &&\
	rm -rf /kafka/site-docs

ADD entry.sh /
ENTRYPOINT ["/entry.sh"]
