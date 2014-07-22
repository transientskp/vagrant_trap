#!bash -ve

git submodule init
git submodule update
vagrant up
vagrant ssh -c "cd /vagrant/trap_project; ./manage.py run job"

