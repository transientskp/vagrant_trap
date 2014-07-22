Introduction
============

Helper files for running the TRAnsient detection Pipeline inside a
virtual machine or contained environment. Read more about TRAP on the 
`tkp website <http://www.transientskp.org/>`_.

To install TRAP you can also use Vagrant. Vagrant is a thin shell around
virtual machine technology.


Terminology
-----------

 * Host - the machine where you install Vagrant on
 * Guest - the virtual machine created by vagrant.


Installation
------------

Download `Virtualbox <https://www.virtualbox.org/>`_ and
`Vagrant <http://www.vagrantup.com/>`_ and install them. On Ubuntu 14.04 you
can simply do::

    $ sudo apt-get install virtualbox vagrant


Usage
-----

First update the git submodules::

    $ git submodule init
    $ git submodule update

Inside the TRAP source tree root run the command::

    $ vagrant up

This will set up a virtualmachine with all dependencies installed, TRAP installed
Banana configured & installed and a webserver serving banana on
http://localhost:8086 .

You can enter the guest by running::

    $ vagrant ssh


The source tree on the host is mounted inside the guest as `/vagrant`. All
files put inside this folder on the host will appear on the guest, and visa
versa. The vagrant provision script created a TRAP project and job config for
you in `/vagrant/trap_project`. This project takes all data files in
`/vagrant/data`.


Running the pipeline
--------------------

There are various ways of running the pipeline, but the easier way is to copy
you data inside the `vagrant_trap/data` folder on the host and then run::

    $ ./run_trap.sh
    
on the host.
