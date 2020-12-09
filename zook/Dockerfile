FROM zookeeper:3.6.2

# COPY /config/zoo.cfg /conf/zoo.cfg
COPY /config/zookeeper-env.sh /conf/zookeeper-env.sh
COPY /entrypoint.sh /entrypoint.sh

CMD ["bash","/entrypoint.sh"]