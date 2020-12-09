import pysolr, sys
from core import settings
from debug import DebugLogger


def get_solr_client():
    logger = DebugLogger('app.api.solr_client.get_solr_client').get_logger()
    
    if settings.APP_ENV != 'mcaas':
        try:
            logger.info('Connecting To Zookeeper Ensemble: %s', settings.ZK_HOST)
            zookeeper = pysolr.ZooKeeper(settings.ZK_HOST)
        except:
            e = sys.exc_info()[0]
            f = sys.exc_info()[1]
            g = sys.exc_info()[2]
            logger.warn('Error Occured: %s \n %s \n %s \n', e, f, g)
            return False

        try:
            logger.info('Connecting To Solr %s Collection', settings.SOLR_COLLECTION)
            return pysolr.SolrCloud(zookeeper, settings.SOLR_COLLECTION, results_cls=dict)
        except:
            e = sys.exc_info()[0]
            f = sys.exc_info()[1]
            g = sys.exc_info()[2]
            logger.warn('Error Occured: %s \n %s \n %s \n', e, f, g)
            return False
    else:
        try:
            logger.info('Connecting to Solr At %s', settings.SOLR_HOST)
            solr = pysolr.Solr(settings.SOLR_HOST, results_cls=dict)
            return solr
        except:
            e = sys.exc_info()[0]
            f = sys.exc_info()[1]
            g = sys.exc_info()[2]
            logger.warn('Error Occured: %s \n %s \n %s \n', e, f, g)
            return False


