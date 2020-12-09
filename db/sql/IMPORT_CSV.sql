COPY solr_titanic(passenger_id, survived, p_class, last_name, first_name,
                    sex , age, sib_sp, parch, ticket, fare, cabin, embarked )
FROM '/titanic/data/titanic_passengers.csv'
DELIMITER ','
CSV HEADER;