SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
SCRIPT_NAME='install-dih'
nl=$'\n'
SCRIPT_DES="Start \e[3mtitanic-solutionid\e[0m cluster before executing this script."
source "$SCRIPT_DIR/../../util/logging.sh"

### Execute after container is running
# ARGUMENT: which solr instance you want to exec in, i.e 1, 2 or 3


if [ "$1" == "--help" ] || [ "$1" == "--h" ] || [ "$1" == "-help" ] || [ "$1" == "-h" ]
then
    help "$SCRIPT_DES" $SCRIPT_NAME
else
    ADD_REPO_CMD="solr package add-repo data-import-handler \"https://raw.githubusercontent.com/rohitbemax/dataimporthandler/master/repo/\""
    INSTALL_DIH_CMD="solr package install data-import-handler"

    log "Add \e[3mdata-import-handler\e[0m Repo To Package Manager Repository" $SCRIPT_NAME
    bash $SCRIPT_DIR/../exec.sh "$ADD_REPO_CMD"

    log "Installing \e[3mdata-import-handler\e[0m Package Inside of Solr Container" $SCRIPT_NAME
    bash $SCRIPT_DIR/../exec.sh "$INSTALL_DIH_CMD"
fi
