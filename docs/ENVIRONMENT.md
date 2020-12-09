### Navigation

[<< Web Application](APPLICATION.md) | [Appendix >>](ENVIRONMENT.md)

# Application Environment

The <i>app.env</i> file located in the project root directory defines several environment variables that need to be set in order for the application to run, either locally or in a container. The Django app requires these variables to populate various settings in the <i>/app/core/settings.py</i> configuration file. In addition, the Dockerfile uses several of the variables to control the dependency versions. Every <i>app.env</i> should contain the following variables,

 - APP_ENV
 - SECRET_KEY
 - ANGULAR_VERSION
 - NODE_VERSION
 - PYTHON_VERSION
 - SOLR_HOST
 - SOLR _POST
 - TODO: Zookeeper variables.

The function of these variable should be relatively self-explanatory, but to be as verbose as possible, so there is no confusion, the following list explains the variables and their use in greater detail.

### APP_ENV, SECRET_KEY

TODO: explain

### ANGULAR_VERSION, NODE_VERSION, PYTHON_VERSION

TODO: explain

### SOLR_HOST, SOLR_PORT

TODO: explain

### Initializing Environment

You can load these variables into your current terminal session by leveraging the <i>env-vars.sh</i> shell script,

> source PROJECT_ROOT/scripts/env-vars.sh ENV

where the <b>ENV</b> is the <i>.env</i> you want to load into your session, i.e. <i>local</i>, <i>container</i>, <i>standalone</i> or <i>cloud</i>.

If running locally with a local database, you should always load in your environment variables before running

> python manage.py runserver

so the <i>/app/core/settings.py</i> database connection properties can be configured properly. By contrasting, when running in a Dockerized environment, these variables are automatically loaded in the container environment through the <i>docker-compose.yml</i>'s <b>env_file<b> attribute.

[<< Web Application](APPLICATION.md) | [SOLR >>](SOLR.md)