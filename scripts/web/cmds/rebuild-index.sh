SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
SCRIPT_NAME='rebuild-index'
nl=$'\n'
SCRIPT_DES="Start \e[3mtitanic\e[0m cluster before executing this script."
source "$SCRIPT_DIR/../../util/logging.sh"

### Execute after container is running

if [ "$1" == "--help" ] || [ "$1" == "--h" ] || [ "$1" == "-help" ] || [ "$1" == "-h" ]
then
    help "$SCRIPT_DES" $SCRIPT_NAME
else
    SCHEMA_CMD="cd ../app && python manage.py rebuild_index --noinput"

    log "Generating Haystack \e[3mmanaged-schema\e[0m Package Inside Of Web Container" $SCRIPT_NAME
    bash $SCRIPT_DIR/../exec.sh "$SCHEMA_CMD"
fi