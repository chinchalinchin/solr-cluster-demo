SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
SCRIPT_NAME='build-environment'
nl=$'\n'
SCRIPT_DES="This script will activate the local environment variables found in ${nl}\
   \e[3mlocal.env\e[0m file. After this, the script will install all the necessary ${nl}\
   software to get a development environment up and running on your local ${nl}\
   machine."
source "$SCRIPT_DIR/util/logging.sh"

if [ "$1" == "--help" ] || [ "$1" == "--h" ] || [ "$1" == "-help" ] || [ "$1" == "-h" ]
then
    help "$SCRIPT_DES" $SCRIPT_NAME
    exit 0
else

    source "$SCRIPT_DIR/util/env-vars.sh" local
    SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
    SCRIPT_NAME='build-environment'

    log 'Checking Node Installation' $SCRIPT_NAME
    if ! command -v node &> /dev/null
    then
        log "Installing Node..." $SCRIPT_NAME
        curl -sL https://deb.nodesource.com/setup_$NODE_VERSION.x | bash - apt-get install -y nodejs
    else 
        log 'Node Already Installed' $SCRIPT_NAME
        log "$(node --version)" $SCRIPT_NAME
        log "Node v$NODE_VERSION Is Recommended" $SCRIPT_NAME
    fi

    log 'Checking Angular CLI Installation' $SCRIPT_NAME
    if ! command -v ng &> /dev/null
    then
        log "Installing Angular CLI" $SCRIPT_NAME
        npm install -g @angular/cli@$ANGULAR_VERSION
    else
        log 'Angular CLI Already Installed' $SCRIPT_NAME
        log "$(ng --version)" $SCRIPT_NAME
        log "Angular v$ANGULAR_VERSION Is Recommended" $SCRIPT_NAME
    fi

    log 'Checking Python Installation' $SCRIPT_NAME
    if ! command -v python &> /dev/null
    then
        log "Installing Python..." $SCRIPT_NAME
        sudo su
        wget https://www.python.org/ftp/python/$PYTHON_VERSION/Python-$PYTHON_VERSION.tgz
        tar xvf Python-$PYTHON_VERSION.tgz
        cd Python-$PYTHON_VERSION
        ./configure --enable-optimizations --with-ensurepip=install
        make -j 8
        make altinstall
    else
        log 'Python Already Installed' $SCRIPT_NAME
        log "$(python --version)" $SCRIPT_NAME
        log "Python v$PYTHON_VERSION Is Recommended" $SCRIPT_NAME
    fi
fi