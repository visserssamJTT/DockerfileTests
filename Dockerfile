FROM ubuntu:14.04
MAINTAINER Sam Vissers <sam.vissers@jtactech.com>
#this is a rough draft docker file if there are surpurfluous elelemnts please feel fre to remove them
#goal of this container is to set up and mantain

# Add the PostgreSQL PGP key to verify their Debian packages.
# It should be the same key as https://www.postgresql.org/media/keys/ACCC4CF8.asc
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys B97B0AFCAA1A47F044F244A07FCC7D46ACCC4CF8

# Add PostgreSQL's repository. It contains the most recent stable release
#     of PostgreSQL, ``9.3``.
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main" > /etc/apt/sources.list.d/pgdg.list

# Update the Ubuntu and PostgreSQL repository indexes and install ``python-software-properties``,
# ``software-properties-common`` and PostgreSQL 9.3
# There are some warnings (in red) that show up during the build. You can hide
# them by prefixing each apt-get statement with DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get -y -q install python-software-properties software-properties-common && apt-get -y -q install postgresql-9.3 postgresql-client-9.3 postgresql-contrib-9.3 && apt-get -y -q install vim
RUN apt-get update
RUN apt-get -y -q install default-jre
RUN apt-get -y -q install default-jdk
RUN apt-get -y -q install software-properties-common
RUN apt-get update


USER postgres

RUN /etc/init.d/postgresql start  && psql --command "CREATE USER pguser WITH SUPERUSER PASSWORD 'pguser';" \
&& psql --command " create table ENTRIES  (TITLE  char(256), BODY char(512), POSTDATE date);"

USER root

# Adjust PostgreSQL configuration so that remote connections to the
# database are possible.
RUN echo "host all  all    0.0.0.0/0  md5" >> /etc/postgresql/9.3/main/pg_hba.conf

# And add ``listen_addresses`` to ``/etc/postgresql/9.3/main/postgresql.conf``
RUN echo "listen_addresses='*'" >> /etc/postgresql/9.3/main/postgresql.conf

# Expose the PostgreSQL port
EXPOSE 5432

RUN mkdir -p /var/run/postgresql && chown -R postgres /var/run/postgresql

# Could not figure out how to set up volumes in the docker file us the -v flag in the run command to do it also name it, makes life easier
#VOLUME  ["/etc/postgresql", "/var/log/postgresql", "/var/lib/postgresql"]

USER postgres

# Set the default command to run when starting the container
CMD ["/usr/lib/postgresql/9.3/bin/postgres", "-D", "/var/lib/postgresql/9.3/main", "-c", "config_file=/etc/postgresql/9.3/main/postgresql.conf" ]

USER root

