FROM openjdk:8-jre
LABEL maintainer="Shen Shan <fjcanyue@hotmail.com>"

ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
ENV ZOOKEEPER_VERSION=3.4.9
ENV ZOOKEEPER_HOME=/opt/zookeeper/zookeeper-$ZOOKEEPER_VERSION
ENV ZOOKEEPER_REPOSITORY=https://mirrors.tuna.tsinghua.edu.cn/apache/zookeeper
ENV ZOOKEEPER_SUB_REPOSITORY=http://mirrors.hust.edu.cn/apache/zookeeper/

ADD start-zoo.sh /usr/local/bin/

RUN chmod a+x /usr/local/bin/start-zoo.sh \
    && mkdir -p /opt/zookeeper \
    && cd /opt/zookeeper \
    && curl -fSL "$ZOOKEEPER_REPOSITORY/zookeeper-$ZOOKEEPER_VERSION/zookeeper-$ZOOKEEPER_VERSION.tar.gz" -o zookeeper.tar.gz || curl -fSL "$ZOOKEEPER_SUB_REPOSITORY/zookeeper-$ZOOKEEPER_VERSION/zookeeper-$ZOOKEEPER_VERSION-bin.tar.gz" -o zookeeper.tar.gz \
    && tar xfvz zookeeper.tar.gz \
    && rm -rf zookeeper.tar.gz

ADD zoo.cfg /opt/zookeeper/zookeeper-$ZOOKEEPER_VERSION/conf/zoo.cfg
ADD java.env /opt/zookeeper/zookeeper-$ZOOKEEPER_VERSION/conf/java.env

# zookeeper
EXPOSE 2181 2888 3888

WORKDIR /opt/zookeeper/zookeeper-$ZOOKEEPER_VERSION

VOLUME ["/opt/zookeeper/conf", "/var/zookeeper"]

ENTRYPOINT /usr/local/bin/start-zoo.sh
