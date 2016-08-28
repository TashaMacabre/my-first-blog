#!/bin/bash

# Install git for version control, pip for install python packages
echo 'Installing git, Python 3, and pip...'

# Locale
locale-gen en_US.UTF-8;
sudo dpkg-reconfigure locales;

export LANGUAGE=en_US.UTF-8;
export LANG=en_US.UTF-8;
export LC_ALL=en_US.UTF-8;

# Update Python
sudo add-apt-repository ppa:fkrull/deadsnakes -y;
sudo apt-get update;
sudo apt-get install python3.5 python3-pip python3.5-dev -y;
sudo apt-get install git -y;

# Install Django
sudo pip install django==1.9

# Add redis
sudo add-apt-repository ppa:chris-lea/redis-server -y;

# Install virtualenv / virtualenvwrapper
# echo 'Installing and configuring virtualenv and virtualenvwrapper...'
# pip install --quiet virtualenvwrapper==4.7.0 Pygments==2.1.1
# mkdir ~vagrant/virtualenvs
# chown vagrant:vagrant ~vagrant/virtualenvs
# printf "\n\n# Virtualenv settings\n" >> ~vagrant/.bashrc
printf "export PYTHONPATH=/usr/lib/python3.4" >> ~vagrant/.bashrc
printf "export WORKON_HOME=~vagrant/virtualenvs\n" >> ~vagrant/.bashrc
printf "export PROJECT_HOME=/vagrant\n" >> ~vagrant/.bashrc
printf "export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3.4\n" >> ~vagrant/.bashrc
printf "source /usr/local/bin/virtualenvwrapper.sh\n" >> ~vagrant/.bashrc

# Some useful aliases for getting started, MotD
echo 'Setting up message of the day, and some aliases...'
cp /vagrant/examples/motd.txt /etc/motd
printf "\nUseful Aliases:\n" >> ~vagrant/.bashrc
printf "alias menu='cat /etc/motd'\n" >> ~vagrant/.bashrc
printf "alias runserver='python manage.py runserver 0.0.0.0:8000'\n" >> ~vagrant/.bashrc
printf "alias ccat='pygmentize -O style=monokai -f terminal -g'\n" >> ~vagrant/.bashrc

# PostgreSQL + PostGIS
sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt trusty-pgdg main" >> /etc/apt/sources.list';
wget --quiet -O - http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc | sudo apt-key add -;
sudo apt-get update;
sudo apt-get install postgresql postgresql-contrib -y;
sudo apt-get -y install libpq-dev;


# Create database superuser;
sudo su - postgres -c "createuser -s vagrant";
createdb -Eutf-8 -l en_US.UTF-8 -T template0 $PROJECT;


echo "Vagrant install complete."
