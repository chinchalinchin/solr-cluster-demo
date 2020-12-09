SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
SCRIPT_NAME='create-collection-with-solr-conf'
nl=$'\n'
SCRIPT_DES="Start \e[3mtitanic-solutionid\e[0m cluster before executing this script."
source "$SCRIPT_DIR/../../util/logging.sh"

# ARGUMENT: which solr instance you want to exec in, i.e 1, 2 or 3

if [ "$1" == "--help" ] || [ "$1" == "--h" ] || [ "$1" == "-help" ] || [ "$1" == "-h" ]
then
    help "$SCRIPT_DES" $SCRIPT_NAME
else
    CMD_STRING="solr create -d /opt/solr/server/solr/configsets/titanic -c titanic"
    bash $SCRIPT_DIR/../exec.sh "$CMD_STRING"
fi