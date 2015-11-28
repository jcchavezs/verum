#!/usr/bin/env bash

EXCLUSION_LIST="'information_schema','performance_schema','mysql'"

#DATABASES_TO_EXCLUDE=""

#for DB in `echo "${DATABASES_TO_EXCLUDE}"`
#do
#    EXCLUSION_LIST="${EXCLUSION_LIST},'${DB}'"
#done

SQLSTMT="SELECT schema_name FROM information_schema.schemata WHERE schema_name NOT IN (${EXCLUSION_LIST})"

MYSQLDUMP_DATABASES="--databases"

for DB in `mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -ANe"${SQLSTMT}"`
do
    MYSQLDUMP_DATABASES="${MYSQLDUMP_DATABASES} ${DB}"
done

MYSQLDUMP_OPTIONS="--routines --triggers"
mysqldump -u root -p${MYSQL_ROOT_PASSWORD} ${MYSQLDUMP_OPTIONS} ${MYSQLDUMP_DATABASES} > /var/backups/mysqldump.sql