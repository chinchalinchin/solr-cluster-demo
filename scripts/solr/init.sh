SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
SCRIPT_NAME='init'
nl=$'\n'
SCRIPT_DES="Start \e[3mtitanic-solutionid\e[0m cluster before executing this script."
source "$SCRIPT_DIR/../util/logging.sh"

log "Invoking \e[3minstall-dih\e[0m Script" $SCRIPT_NAME
bash $SCRIPT_DIR/cmds/install-dih.sh

log "Invoking \e[3mcreate-collection-zook\e[0m Script" $SCRIPT_NAME
bash $SCRIPT_DIR/cmds/create-collection-zook.sh

log "Invoking \e[3mdeploy-dih\e[0m Script" $SCRIPT_NAME
bash $SCRIPT_DIR/cmds/deploy-dih.sh

# log "Invoking \e[3mpost-data\e[0m Script" $SCRIPT_NAME
# bash $SCRIPT_DIR/cmds/post-data.sh