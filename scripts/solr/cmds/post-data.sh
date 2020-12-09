SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
SCRIPT_NAME='post-sample-data-to-solr'
nl=$'\n'
SCRIPT_DES=""
source "$SCRIPT_DIR/../../util/logging.sh"

if [ "$1" == "--help" ] || [ "$1" == "--h" ] || [ "$1" == "-help" ] || [ "$1" == "-h" ]
then
    help "$SCRIPT_DES" $SCRIPT_NAME
else
    CMD_STRING="post -c titanic /opt/data/titanic_passengers.csv"
    bash $SCRIPT_DIR/../exec.sh "$CMD_STRING"
fi