ARG MARIADB_VERSION=10.5
FROM mariadb:${MARIADB_VERSION}

LABEL maintainer="David M. Ramos <DavidMRGaona@gmail.com>"

COPY my.cnf /etc/mysql/conf.d/my.cnf

CMD ["mysqld"]

EXPOSE 3306
