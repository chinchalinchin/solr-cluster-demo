COPY solr_titanic()
FROM '/titanic/data/titanic_passengers.csv'
DELIMITER ','
CSV HEADER;