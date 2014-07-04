#!/bin/bash

# The purpose of this script is to start Redmine for the first time which
# requires several configurations.  This script handles the following:
# - Prompting for a database password
# - Creating and configuring the database.yml file
# - Building and running docker containers
# - Creating Redmine user with proper permissions
# - Creating Redmine database and add default data
#
# For documentation on configuring Redmine:
# http://www.redmine.org/projects/redmine/wiki/redmineinstall

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "Starting Initilize Redmine environment script"

# Collect Redmine database password
echo -n "Please enter the password to use for the Redmine MySQL user [ENTER]: "
read password

echo "Creating database.yml (if it doesn't already exist)"
cp -n $DIR/database.yml ./redmine/config
sed -i 's/<password>/'$password'/g' ./redmine/config/database.yml

echo "Building and then running containers."
fig build
fig up -d

# Get mariadb container information
mariadb_container_id=$(docker ps | grep -e 'p[ ]*figredmine_mariadb_1,' | awk '{print $1}')
mariadb_container_ip=$(docker inspect -f '{{ .NetworkSettings.IPAddress }}' $mariadb_container_id)
mariadb_super_password=$(docker logs $mariadb_container_id | grep MARIADB_PASS | awk '{split($0,a,"="); print a[2]}')
echo "Found mariadb container $mariadb_container_id at $mariadb_container_ip with super user password $mariadb_super_password"

echo "Allow MySQL to start up (wait 10 seconds)"
for i in {1..10}; do printf "$((11-i)) "; sleep 1; done; echo ""

echo "Creating Redmine user"
fig run --rm mariadb mysql -u super -p$mariadb_super_password -h $mariadb_container_ip -e 'CREATE USER '"'"'redmine'"'"'@'"'"'172.%'"'"' IDENTIFIED BY '"'"$password"'"''
fig run --rm mariadb mysql -u super -p$mariadb_super_password -h $mariadb_container_ip -e 'GRANT ALL PRIVILEGES ON redmine_production.* TO '"'"'redmine'"'"'@'"'"'172.%'"'"''

echo "Creating Redmine database and initializing with default data"
fig run --rm passenger bash -c 'cd /home/app/redmine; RAILS_ENV=production rake db:create && RAILS_ENV=production rake db:migrate && rake generate_secret_token && RAILS_ENV=production rake redmine:load_default_data'
