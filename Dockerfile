FROM alpine:3.20.6

## Install Kafka+Zookeeper
RUN apk --no-cache add bash curl openjdk8-jre-base nss tini krb5 &&\
	curl https://archive.apache.org/dist/kafka/2.1.1/kafka_2.12-2.1.1.tgz | tar xz &&\
	mv kafka_2.12-2.1.1 /kafka &&\
	rm -rf /kafka/site-docs /kafka/bin/windows &&\
	chmod -R g=u /kafka &&\
	rm /usr/bin/nc

ENV PATH=/kafka/bin:${PATH}

EXPOSE 2181 2888 3888 9092

# The entry.sh script needs to modify server.properties.
# Instead, we move server.properties to server.properties.original,
# and then we setup server.properties as a symbolic link to /tmp/server.properties.
# The entry.sh script copies server.properties.original into /tmp, where it can be modified
RUN mv /kafka/config/server.properties /kafka/config/server.properties.original && \
      ln -s /tmp/server.properties /kafka/config/server.properties

COPY entry.sh /
ENTRYPOINT ["/sbin/tini", "--", "/entry.sh"]
