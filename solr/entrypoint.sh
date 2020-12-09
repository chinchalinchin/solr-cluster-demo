
if [ "$APP_ENV" != "standalone" ]
then
    solr zk upconfig -n titanic -d /opt/solr/server/solr/configsets/titanic -z "$ZK_HOST"
    solr zk cp file:/var/solr/data/solr.xml zk:/solr.xml -z "$ZK_HOST"
fi
echo "Connecting to Zookeeper Ensemble At $ZK_HOST"
solr start -f -c -z "$ZK_HOST" -Denable.packages=true