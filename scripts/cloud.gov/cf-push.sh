SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
SCRIPT_NAME='cf-push'
source "$SCRIPT_DIR/../util/logging.sh"

# log into cf cli before using this script. provide -b/--build flag to 
# build the application artifacts before pushing to the cloud.

APP_NAME="titanic"

source "$SCRIPT_DIR/../util/env-vars.sh" cloud
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

if [ "$1" == "--build" ] || [ "$1" == "-b" ]
then
    log "Invoking \e[3mbuild-application\e[0m Application Script"
    bash $SCRIPT_DIR/../build-application.sh
fi

log "Pushing Application $APP_NAME To \e[3mcloud.gov\e[0m With \e[3m--no-start\e[0m Flag" $SCRIPT_NAME
cd $SCRIPT_DIR/../../
cf push --no-start

log "Creating Application $APP_NAME Environment On \e[3mcloud.gov\e[0m" $SCRIPT_NAME
log "Setting SECRET_KEY On \e[3mcloud.gov\e[0m" $SCRIPT_NAME
cf set-env $APP_NAME SECRET_KEY $SECRET_KEY

log "Starting Application On \e[3mcloud.gov\e[0m"
cf start $APP_NAME

