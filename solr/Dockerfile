FROM solr:8.6.3

# SET ROOT PERMISSIONS
USER root

# CUSTOM SERVER CONFIG
COPY /config/solr.xml /var/solr/data/solr.xml

# POSTGRESQL JDBC DRIVER
RUN mkdir /var/solr/data/lib
COPY /config/postgresql-42.2.18.jar /var/solr/data/lib/postgresql-42.2.18.jar

# CUSTOM CONFIGSET
RUN mkdir /opt/solr/server/solr/configsets/titanic
COPY /config/conf /opt/solr/server/solr/configsets/titanic/conf

# SAMPLE DATA
RUN mkdir /opt/data
COPY /data/ /opt/data

# COPY ENTRYPOINT
COPY /entrypoint.sh /entrypoint.sh

# DON'T RUN SOLR IN ROOT
USER solr
CMD ["bash","/entrypoint.sh"]