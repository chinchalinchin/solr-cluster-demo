SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
SCRIPT_NAME='run-solr-standalone'
nl=$'\n'
SCRIPT_DES="${nl}"
source "$SCRIPT_DIR/util/logging.sh"

if [ "$1" == "--help" ] || [ "$1" == "--h" ] || [ "$1" == "-help" ] || [ "$1" == "-h" ]
then
    help "$SCRIPT_DES" $SCRIPT_NAME
    exit 0
else
    log "Prepping Environment For Build" $SCRIPT_NAME
    APP_DIR=$SCRIPT_DIR/../app

    log "Initialing Environment" $SCRIPT_NAME
    source $SCRIPT_DIR/util/env-vars.sh standalone
        # reset SCRIPT_DIR because sourcing changes its value
    SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

    log 'Deleting Dangling Images' $SCRIPT_NAME
    docker rmi -f $(docker images --filter "dangling=true" -q)

    log 'Clearing Docker Cache' $SCRIPT_NAME
    docker system prune -f

    cd $APP_DIR
    log "Environment Prepped" $SCRIPT_NAME

    log "Building Docker Image"
    docker build --tag=$WEB_IMG_TAG:$WEB_IMG_V $APP_DIR

    log "Starting Docker Container"
    docker run -p $SOLR_PORT:$SOLR_PORT --name="titanic_solr" $WEB_IMG_TAG:$WEB_IMG_V
fi