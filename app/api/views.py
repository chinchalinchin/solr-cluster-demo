
from django.http import JsonResponse
from api.solr_client import get_solr_client
from debug import DebugLogger

debugger = DebugLogger('app.api.views.search')

def search(request):
    logger = debugger.get_logger()

    logger.info('Retrieving Solr Client')
    solr = get_solr_client()

    if solr is not False:
        query = request.GET.get('q')
        results = solr.search(query).get('response').get('docs')

        for result in results:
            logger.info("Result")
            for prop in result:
                logger.info('result.attribute %s = %s', prop, result.get(prop))
            debugger.print_line()

        return JsonResponse(results, safe=False)
    else:
        return JsonResponse({'message': 'error'}, safe=False)
    