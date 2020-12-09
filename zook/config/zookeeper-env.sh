ZOO_LOG_DIR="/logs"
ZOO_LOG4J_PROP="INFO,ROLLINGFILE"

SERVER_JVMFLAGS="-Xms2048m -Xmx2048m -verbose:gc -Xlog:gc* -Xlog:gc:$ZOO_LOG_DIR/zookeeper_gc.log"