### Navigation 
[<< Environment](ENVIRONMENT.md) | [APPENDIX >>](APPENDIX.md)

## Overview

The <b>Solr</b> development cluster consists of a single <b>Solr</b> instance, a single <b>Zookeeper</b> instance and a single <b>Postgres</b> instance. This setup has been adopted to mimic how the application will work in production. <b>postgres</b> will act a datasource that <b>Solr</b> can index and <b>Zookeeper</b> will hold the configuration files and perform certain adminstrative actions for <b>Solr</b>.

## Standalone Mode

Solr can be launched without the other applications in the cluster by using,

./scripts/run-solr-standalone.sh

If you have not configured a <i>standalone.env</i> from the <i>.sample.env</i>, this script will prompt you to configure one and then reinvoke the script.

## DataImportHandler Plugin

The DataImportHandler Solr previously used in versions > 8.5 has been deprecated and is now maintained as a third party plugin. Unforunately, the plugin only currently ships with MariaDB support. However, this shortcoming can be easily fixed by packaging the appropriate JDBC driver with the Solr image. In the Solr Dockerfile, find the section where the JDBC driver is copied in the <i>/var/solr/data/lib/</i> directory and add it the JDBC driver you wish to utilize.

In addition to bundling the JDBC jar with the Solr image, you must also executed several commands with Solr's package manager that will actually install the plugin into the running Solr instance. These commands must be executed <i>inside</i> of the Solr container <i>after</i> the application cluster has been launched.

First, you need to install the DataImportHandler plugin through the Solr package manager. Next, a collection must exist before the DataImportHandler can be 'deployed' to it through the package manager, so the second step after installing the plugin is to create a collection named <i>titanic</i> using the <i>titanic</i> configset. Once the collection is ready, you can deploy the DataImportHandler to it. ([See DIH docs for more info](https://github.com/rohitbemax/dataimporthandler)). The whole process has been automated with the following script,

> ./scripts/solr/init.sh

Once the DataImportHandler has been installed and deployed, assuming the <b>postgres</b> datasource has been pre-loaded with the provided sample-data (see below for more information), the datasource can be indexex through the Solr admin UI exposed at <i>localhost:8983/solr</i> or through the Admin Api ([See Solr docs for more info](https://lucene.apache.org/solr/guide/6_6/coreadmin-api.html)) 

## External Zookeeper

TODO: explain

## Postgres Datasource

TODO: explain

### Navigation 
[<< Environment](ENVIRONMENT.md) | [Appendix >>](APPENDIX.md)