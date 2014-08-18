#!bash -ve

vagrant up
vagrant ssh -c "cd /vagrant/trap_project; ./manage.py run job"

