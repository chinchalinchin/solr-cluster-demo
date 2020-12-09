SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
SCRIPT_NAME='build-containers'
nl=$'\n'
SCRIPT_DES="This script will stop and remove any Docker containers currently running ${nl}\
   on your machine, build a fresh application image and delete any dangling ${nl}\
   images leftover after the build completes. Running this script will remove  ${nl}\
   the database container and you will lose any data stored within it unless  ${nl}\
   you have manually backed it up. Run this script with care."
source "$SCRIPT_DIR/util/logging.sh"

if [ "$1" == "--help" ] || [ "$1" == "--h" ] || [ "$1" == "-help" ] || [ "$1" == "-h" ]
then
    help "$SCRIPT_DES" $SCRIPT_NAME
else

    source $SCRIPT_DIR/util/env-vars.sh container
    SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

    log 'Removing Running Containers' $SCRIPT_NAME
    docker-compose down

    log 'Clearing Docker Cache' $SCRIPT_NAME
    docker system prune -f

    log 'Building Application Image' $SCRIPT_NAME
    docker-compose build

    log 'Deleting Dangling Images' $SCRIPT_NAME
    docker rmi -f $(docker images --filter "dangling=true" -q)

    log 'Application Image Built. Run \e[3mdocker-compose up\e[0m To Start Application Server Container' $SCRIPT_NAME
fi