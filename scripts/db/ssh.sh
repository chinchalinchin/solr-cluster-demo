SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
SCRIPT_NAME='exec-into'
nl=$'\n'
SCRIPT_DES="Start \e[3mtitanic\e[0m cluster before executing this script."
source "$SCRIPT_DIR/../util/logging.sh"

CONTAINER_ID="$(docker container ps --filter name=db --quiet)"

log "SSH'ing Into of Container ID $CONTAINER_ID" $SCRIPT_NAME
winpty docker exec -it $CONTAINER_ID "psql --username=postgres" 