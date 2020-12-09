
# Solr / Zookeeper / Postgres Container Cluster

## Quickstart
This is a <b>Django</b> web application configured to run in a Docker network with three <b>Solr</b> instances, three <b>Zookeeper</b> instance and a <b>Postgres</b> instance. The <b>Postgres</b> container acts as a datasource for <b>Solr</b> and does not interface with the web application at all. 

To begin, a simple <i>docker-compose up</i> will bring the application cluster up and bind the <b>web</b> application container to <i>localhost:8000</i>, the <b>Solr</b> container to <i>localhost:8981-8983</i>, the <b>Zookeeper</b> container on <i>localhost:2181-2183</i> and the <b>Postgres</b> container on <i>localhost:5432</i>. However, since the application build process is hardcoded into the Docker image (i.e., no volumes are mounted), the <i>/scripts/build-containers.sh</i> is recommended to perform some system clean up before launching the application cluster, i.e.,

>./scripts/build-containers.sh && docker-compose up

Once the cluster is running, you will need to populate the database container with the sample data using the provided SQL scripts in <i>/db/sql/</i> directory. These scripts must be executed <i>inside</i> the <b>postgres</b> container. The necessary steps have been included in the <i>/scripts/db/cmds/import-data.sh</i> BASH script, i.e. execute,

>./scripts/db/cmds/import-data.sh

Next, you will need to install the DataImportHandler plugin and create the <b>titanic</b> collection. All of the necessary steps have been included in the <i>/scripts/solr/init.sh</i> BASH script, i.e. execute,

>./scripts/solr/init.sh

Once the database has been populated, the DataImportHandler plugin has been installed in Solr, and a <b>titanic</b> collection has been created, you will need to tell Solr to manually index the datasource, either through the admin UI exposed at <i>localhost:8983</i> or through the Admin Collection API (see Solr documentation(TODO: link goes here))

## Application Images

The <b>Solr</b>, <b>Zookeeper</b> and <b>Postgres</b> Dockerfiles can be found in the <i>/solr/</i>, <i>/zook/</i> and <i>/db/</i> directories, respectively, along with their corresponding configuration files. These configuration files are hardcoded into the Dockerfile, i.e. directly into the virtual filesystem of the container, instead of through volume mounts, due to how the MCaaS environment is currently configured to deploy applications. In the future, when volumes and filesystem mounts become availabe on MCaaS, consideration should be given to mounting these configuration files through external volumes, along with any data volumes the <b>Solr</b>/<b>Zookeeper</b> instances will rely on in production (the <b>postgres</b> container will be replaced in production with either a database service for tenants on MCaaS or an external Redshift database accessible in MCaaS).

## Documentation

- [Setup](docs/SETUP.md)<br>
- [Web Application](docs/APPLICATION.md)<br>
- [Environment](docs/ENVIRONMENT.md)<br>
- [Solr](docs/SOLR.md)<br>
- [Appendix](docs/APPENDIX.md)