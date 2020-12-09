SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
SCRIPT_NAME='run-zook-standalone'
nl=$'\n'
SCRIPT_DES="${nl}"
source "$SCRIPT_DIR/util/logging.sh"

if [ "$1" == "--help" ] || [ "$1" == "--h" ] || [ "$1" == "-help" ] || [ "$1" == "-h" ]
then
    help "$SCRIPT_DES" $SCRIPT_NAME
    exit 0
else
    log "Prepping Environment For Build" $SCRIPT_NAME
    APP_DIR=$SCRIPT_DIR/../zook

    log "Initialing Environmnet" $SCRIPT_NAME
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
    docker build --tag=$ZK_IMG_TAG:$ZK_IMG_V $APP_DIR

    log "Starting Docker Container"
    docker run -p 2181:2181 -p 2888:2888 -p 3888:3888 -p 8080:8080 --name="titanic_zook" $ZK_IMG_TAG:$ZK_IMG_V
fi