SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
SCRIPT_NAME='create-collection-with-zook-conf'
nl=$'\n'
SCRIPT_DES=""
source "$SCRIPT_DIR/../../util/logging.sh"

# must be executed after collection has been created??? yes.
# ARGUMENT: which solr instance you want to exec in, i.e 1, 2 or 3

if [ "$1" == "--help" ] || [ "$1" == "--h" ] || [ "$1" == "-help" ] || [ "$1" == "-h" ]
then
    help "$SCRIPT_DES" $SCRIPT_NAME
else
    CMD_STRING="solr package deploy data-import-handler -y -collections titanic"
    bash $SCRIPT_DIR/../exec.sh "$CMD_STRING"
fi