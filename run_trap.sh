#!bash -ve

git submodule init
git submodule update

pushd tkp
# make sure we have the latest version
git pull
git branch
# get the test data
git submodule init
git submodule update
popd

pushd banana
# make sure we have the last version
git pull
git branch
popd


vagrant up
vagrant ssh -c "cd /vagrant/trap_project; ./manage.py run job"

