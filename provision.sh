#!/bin/bash -ev

cp /vagrant/conf/profile /home/vagrant/.profile
. /home/vagrant/.profile

cp /vagrant/conf/apt.sources.list /etc/apt/sources.list

## install all requirements
apt-get install -y software-properties-common
add-apt-repository ppa:ska-sa/main
apt-get update
cat /vagrant/conf/debian_packages | xargs apt-get install -y -q

## compile and install trap
mkdir -p /vagrant/tkp/build
cd /vagrant/tkp/build
rm -rf *
cmake .. -DINSTALL_TKP=OFF
make clean
make
make install
cd ..
pip install -r requirements.txt

## create trap project
cd /vagrant/
if [ ! -d trap_project ]; then
    /vagrant/tkp/tkp/bin/tkp-manage.py initproject trap_project
    cd /vagrant/trap_project
    ./manage.py initjob job || true
    cp /vagrant/conf/pipeline.cfg pipeline.cfg
    cp /vagrant/conf/images_to_process.py job/images_to_process.py
fi


## setup & configure banana
cd /vagrant/banana
pip install -r requirements.txt
cp /vagrant/conf/apache.conf /etc/apache2/sites-enabled/000-default.conf 
cp /vagrant/conf/banana_settings.py /vagrant/banana/bananaproject/settings/local.py
./manage.py collectstatic --noinput
service apache2 restart

## setup a database for TRAP
echo "CREATE USER vagrant WITH PASSWORD 'vagrant' CREATEDB;" | sudo -u postgres psql || true
sudo -u vagrant createdb vagrant || true
sudo -u vagrant PYTHONPATH=/vagrant/tkp /vagrant/tkp/tkp/bin/tkp-manage.py  initdb -y
