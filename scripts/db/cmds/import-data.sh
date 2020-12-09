SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
SCRIPT_NAME='create-collection-with-solr-conf'
nl=$'\n'
SCRIPT_DES="Start \e[3mtitanic\e[0m cluster before executing this script."
source "$SCRIPT_DIR/../../util/logging.sh"

if [ "$1" == "--help" ] || [ "$1" == "--h" ] || [ "$1" == "-help" ] || [ "$1" == "-h" ]
then
    help "$SCRIPT_DES" $SCRIPT_NAME
else
    DB_STRING="psql --username=postgres -f /titanic/sql/CREATE_SOLR_DB.sql"
    TBL_STRING="psql --username=postgres -d solr_db -f /titanic/sql/CREATE_SOURCE_TABLE.sql"
    IMP_STRING="psql --username=postgres -d solr_db -f /titanic/sql/IMPORT_CSV.sql"
    bash $SCRIPT_DIR/../exec.sh "$DB_STRING"
    bash $SCRIPT_DIR/../exec.sh "$TBL_STRING"
    bash $SCRIPT_DIR/../exec.sh "$IMP_STRING"
fi