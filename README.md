# docker-zookeeper

[Zookeeper docker](https://github.com/fjcanyue/docker-zookeeper) image three supported modes:

* Local (Standalone) Mode
* Pseudo-Distributed Mode
* Fully-Distributed Mode


### Standalone Mode
Deoply only one zookeeper instance to single matchine.

docker-compose.yml
```
version: '2'
services:
    zookeeper1:
        container_name: zookeeper1
        hostname: zk1
        image: fjcanyue/zookeeper
        restart: always
        expose:
            - "2181"
        ports:
            - "2181:2181"
        environment:
            ZOOKEEPER_PORT: 2181
```

### Pseudo-Distributed Mode
Deoply three zookeeper instances to single matchine.

docker-compose.yml
```
version: '2'
services:
    zookeeper1:
        container_name: zookeeper1
        hostname: zk1
        image: shebao/zk
        restart: always
        expose:
            - "2181"
            - "2888"
            - "3888"
        ports:
            - "2181:2181"
        environment:
            ZOOKEEPER_PORT: 2181
            ZOOKEEPER_MYID: 1
            ZOOKEEPER_NODES: server.1=zk1:2888:3888,server.2=zk2:2888:3888,server.3=zk3:2888:3888
        networks:
            isolated_network:
              aliases:
                  - zk1

    zookeeper2:
        container_name: zookeeper2
        hostname: zk2
        image: shebao/zk
        restart: always
        expose:
            - "2181"
            - "2888"
            - "3888"
        ports:
            - "2182:2181"
        environment:
            ZOOKEEPER_PORT: 2181
            ZOOKEEPER_MYID: 2
            ZOOKEEPER_NODES: server.1=zk1:2888:3888,server.2=zk2:2888:3888,server.3=zk3:2888:3888
        networks:
            isolated_network:
              aliases:
                  - zk2

    zookeeper3:
        container_name: zookeeper3
        hostname: zk3
        image: shebao/zk
        restart: always
        expose:
            - "2181"
            - "2888"
            - "3888"
        ports:
            - "2183:2181"
        environment:
            ZOOKEEPER_PORT: 2181
            ZOOKEEPER_MYID: 3
            ZOOKEEPER_NODES: server.1=zk1:2888:3888,server.2=zk2:2888:3888,server.3=zk3:2888:3888
        networks:
            isolated_network:
              aliases:
                  - zk3

networks:
  isolated_network:
    driver: bridge
```

### Fully-Distributed Mode
Deoply three zookeeper instances to three matchines.

docker-compose.yml on matchine 1
```
version: '2'
services:
    zookeeper1:
        container_name: zookeeper1
        hostname: zk1
        image: shebao/zk
        restart: always
        expose:
            - "2181"
            - "2888"
            - "3888"
        ports:
            - "2181:2181"
        environment:
            ZOOKEEPER_PORT: 2181
            ZOOKEEPER_MYID: 1
            ZOOKEEPER_NODES: server.1=matchine1:2888:3888,server.2=matchine2:2888:3888,server.3=matchine3:2888:3888            
```

docker-compose.yml on matchine 2

```
    zookeeper2:
        container_name: zookeeper2
        hostname: zk2
        image: shebao/zk
        restart: always
        expose:
            - "2181"
            - "2888"
            - "3888"
        ports:
            - "2181:2181"
        environment:
            ZOOKEEPER_PORT: 2181
            ZOOKEEPER_MYID: 2
            ZOOKEEPER_NODES: server.1=matchine1:2888:3888,server.2=matchine2:2888:3888,server.3=matchine3:2888:3888
```

docker-compose.yml on matchine 3

```

    zookeeper3:
        container_name: zookeeper3
        hostname: zk3
        image: shebao/zk
        restart: always
        expose:
            - "2181"
            - "2888"
            - "3888"
        ports:
            - "2181:2181"
        environment:
            ZOOKEEPER_PORT: 2181
            ZOOKEEPER_MYID: 3
            ZOOKEEPER_NODES: server.1=matchine1:2888:3888,server.2=matchine2:2888:3888,server.3=matchine3:2888:3888
```
