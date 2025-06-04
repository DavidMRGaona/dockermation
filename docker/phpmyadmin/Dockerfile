ARG PHPMYADMIN_VERSION=5.2
FROM phpmyadmin/phpmyadmin:${PHPMYADMIN_VERSION}

LABEL maintainer="David M. Ramos <DavidMRGaona@gmail.com>"

# Add volume for sessions to allow session persistence
VOLUME /sessions

# We expose phpMyAdmin on port 80
EXPOSE 80
