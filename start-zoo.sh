#!/bin/bash
set -e
set -x

ZOOKEEPER_PORT=${ZOOKEEPER_PORT:-2181}
ZOOKEEPER_MYID=${ZOOKEEPER_MYID:-1}
ZOOKEEPER_MAXCLIENTS=${ZOOKEEPER_MAXCLIENTS:-50}
ZOOKEEPER_NODES=${ZOOKEEPER_NODES:-}
ZOOKEEPER_HOME=${ZOOKEEPER_HOME}

sed -i "s/clientPort=2181/clientPort=${ZOOKEEPER_PORT}/g" ${ZOOKEEPER_HOME}/conf/zoo.cfg
sed -i "s/maxClientCnxns=60/maxClientCnxns=${ZOOKEEPER_MAXCLIENTS}/g" ${ZOOKEEPER_HOME}/conf/zoo.cfg

nodes=$(echo $ZOOKEEPER_NODES | tr "," "\n")

for node in $nodes
do
    echo $node >> ${ZOOKEEPER_HOME}/conf/zoo.cfg
done

cat ${ZOOKEEPER_HOME}/conf/zoo.cfg

if [ ! -d "/var/zookeeper/data" ]; then
    mkdir /var/zookeeper/data
fi


echo ${ZOOKEEPER_MYID} > /var/zookeeper/data/myid

${ZOOKEEPER_HOME}/bin/zkServer.sh start-foreground
