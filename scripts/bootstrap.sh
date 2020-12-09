SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
SCRIPT_NAME='bootstrap'
nl=$'\n'
SCRIPT_DES="This script is designed to start up the application server \e[3minside\e[0m${nl}\
   of the container created by the \e[1mDockerfile\e[0m in the project's root${nl}\
   directory. This script builds the Angular Javascript bundles,${nl}\
   collects all of the static files to be served by the \e[2mgunicorn\e[0m web ${nl}\
   server, and migrates Django's models to the database connection ${nl}\
   configured in the \e[3mcontainer.env\e[0m environment file."

source "$SCRIPT_DIR/util/logging.sh"

if [ "$1" == "--help" ] || [ "$1" == "--h" ] || [ "$1" == "-help" ] || [ "$1" == "-h" ]
then
    help "$SCRIPT_DES" $SCRIPT_NAME
else

    ########################################################
    ## PRE-DEPLOYMENT CONTAINER TASKS 
    #######################################################
    cd $SCRIPT_DIR/../app/
    log "Navigating To Django Project Root: $(pwd)" $SCRIPT_NAME

    log 'Debugging Django Settings' $SCRIPT_NAME
    python debug.py
    #########################################################

    #########################################################
    ## CONTAINER APPLICATION ENTRYPOINT
    #########################################################
    if [ "$APP_ENV" == "local" ]
    then
        log 'Binding WSGI App To Gunicorn Web Server On localhost:8000' $SCRIPT_NAME
        gunicorn core.wsgi:application --workers 3
    fi
    if [ "$APP_ENV" == "container" ]
    then
        log 'Binding WSGI App To Gunicorn Web Server On 0.0.0.0:8000' $SCRIPT_NAME 
        gunicorn core.wsgi:application --bind=0.0.0.0 --workers 3
    fi
    if [ "$APP_ENV" == "standalone" ]
    then
        log 'Binding WSGI App To Gunicorn Web Server On 0.0.0.0:8000' $SCRIPT_NAME 
        gunicorn core.wsgi:application --bind=0.0.0.0 --workers 3
    fi
    if [ "$APP_ENV" == "mcaas" ]
    then
        log 'Binding WSGI App To Gunicorn Web Server On 0.0.0.0:8000 With DDTrace' $SCRIPT_NAME
        ddtrace-run gunicorn core.wsgi:application --bind=0.0.0.0 --workers 3
    fi
    if [ "$APP_ENV" == "cloud" ]
    then
        log 'Binding WSGI App To Gunicorn Web Server' $SCRIPT_NAME
        gunicorn core.wsgi:application
    fi
    #########################################################

fi