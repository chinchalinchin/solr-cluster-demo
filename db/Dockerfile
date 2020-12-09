FROM postgres:latest

USER root
RUN mkdir /titanic/ && mkdir /titanic/sql/ && mkdir /titanic/data/
COPY /sql /titanic/sql
COPY /data /titanic/data