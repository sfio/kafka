FROM alpine

RUN apk add --no-cache bash curl openjdk8-jre

RUN curl http://www-us.apache.org/dist/zookeeper/zookeeper-3.4.10/zookeeper-3.4.10.tar.gz | tar xz &&\
	mv zookeeper-3.4.10 /zk &&\
	mv /zk/conf/zoo_sample.cfg /zk/conf/zoo.cfg

RUN curl http://www-us.apache.org/dist/kafka/1.0.0/kafka_2.11-1.0.0.tgz | tar xz &&\
	mv kafka_2.11-1.0.0 /kafka

ADD entry.sh /
ADD create-topics.sh /
ENTRYPOINT ["/entry.sh"]
