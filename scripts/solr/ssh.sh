SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
SCRIPT_NAME='exec-into'
nl=$'\n'
SCRIPT_DES="Start \e[3mtitanic-solutionid\e[0m cluster before executing this script."
source "$SCRIPT_DIR/../util/logging.sh"

# ARGUMENT: which solr instance you want to exec in

CONTAINER_ID="$(docker container ps --filter name=solr --quiet)"

log "SSH'ing Into of Container ID $CONTAINER_ID" $SCRIPT_NAME
winpty docker exec -it $CONTAINER_ID bash 