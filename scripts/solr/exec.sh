SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
SCRIPT_NAME='exec'
nl=$'\n'
SCRIPT_DES="Execute a string of commands inside of one of the \e[3mtitanic-solr\e[0m container. The ${nl}\
    command must be provided as a string enclosed in quotation marks and you must specify which ${nl}
    container in the cluster you want to execute the command in with an integer, i.e., ${nl}${nl}\
        bash ./exec.sh 1 \"do something in solr container\"${nl}${nl}\
    As such, make sure to start \e[3mtitanic-solutionid\e[0m cluster before executing this script."
source "$SCRIPT_DIR/../util/logging.sh"

# ARGUMENT: which solr instance you want to exec in

if [ "$1" == "--help" ] || [ "$1" == "--h" ] || [ "$1" == "-help" ] || [ "$1" == "-h" ]
then
    help "$SCRIPT_DES" $SCRIPT_NAME
else
    CONTAINER_ID="$(docker container ps --filter name=solr1 --quiet)"

    log "Executing \"$1\" Inside of Container ID #$CONTAINER_ID" $SCRIPT_NAME
    docker exec $CONTAINER_ID bash -c "$1"
fi