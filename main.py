# Activate python env
# Run postgres


#!/usr/bin/python

# Install psycopg2 package.
#   sudo apt-get install libq-dev # solve errors of pg_config path not found
#   pip3 install psycopg2
#   pip3 install psycopg2-binary

import psycopg2

from config import config

conn = psycopg2.connect(database = "mimic", 
                        user = "postgres", 
                        host= 'localhost',
                        password = "postgres",
                        port = 5432)





