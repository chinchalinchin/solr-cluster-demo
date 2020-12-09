SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
SCRIPT_NAME='exec-into'
nl=$'\n'
SCRIPT_DES=""
source "$SCRIPT_DIR/../util/logging.sh"

CONTAINER_ID="$(docker container ps --filter name=zook --quiet)"

log "SSH'ing Into of Container ID $CONTAINER_ID" $SCRIPT_NAME
winpty docker exec -it $CONTAINER_ID bash 