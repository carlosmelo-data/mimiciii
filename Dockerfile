# syntax=docker/dockerfile:1

FROM ubuntu:latest
# ARG DEBIAN_FRONTEND=noninteractive
ARG TZ=Etc/UTC

WORKDIR /app

# Install sudo
RUN su -
RUN apt update
RUN apt install sudo
RUN exit

# Install lsb_release and others
RUN sudo apt update \
    && apt -y upgrade \
    && apt install -y python3 \
    && apt install -y lsb-core \
    && apt install wget \
    && apt install -y git \
    && apt install tar \
    && apt install gzip \
    && apt install nano

# Create the file repository configuration:
RUN sudo sh -c 'echo "deb https://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'

# Import the repository signing key:
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -

# Update the package lists:
RUN sudo apt-get update

# Install the latest version of PostgreSQL.
# If you want a specific version, use 'postgresql-12' or similar instead of 'postgresql':
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install postgresql

# Clone the mimic-code repo
RUN git clone https://github.com/MIT-LCP/mimic-code.git

# Create directory for the mimic data
RUN cd / \
    && mkdir data \
    && cd data

# Change to the /data
# cd /data

# Download the MIMIC III files
# wget -r -N -c -np --user carlosmelo --ask-password https://physionet.org/files/mimiciii/1.4/

# Decompress the data files
# cd /data/physionet.org/files/mimiciii/1.4/
# gunzip -dkv *.gz

# Edit some postgresql configuration files
# sudo nano /etc/postgresql/14/main/pg_ident.conf
# MAPNAME       SYSTEM-USERNAME         PG-USERNAME
# user1         root                    postgres
# Where SYSTEM-USERNAME is <computer-username>, replace to root

# sudo nano /etc/postgresql/14/main/pg_hba.conf
# TYPE  DATABASE        USER            ADDRESS                 METHOD
# local   all             postgres                                trust
# Where METHOD is peer, replace to trust

# Change to the buildmimic/postgres/ directory
# cd /app/mimic-code/mimic-iii/buildmimic/postgres/
# sudo service postgresql start
# sudo service postgresql status

# Create MIMIC from a set of zipped CSV files
# make create-user mimic datadir="/data/physionet.org/files/mimiciii/1.4"

