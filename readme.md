Vagrant Debian LAMP Stack
=========================
 - Debian Jessie 8.0 64bits
 - Vbox additions
 - Puppet
 - PHP 5.6
 - Apache 2.4
 - Mysql 5.5

L'IP de la machine Vagrant est 192.168.33.10.
L'utilisateur est vagrant avec le mot de passe vagrant.

Pré-requis
----------
 - Vagrant
 - VirtualBox

Installation
------------
Placez-vous dans le dossier courant et éxecutez la commande : `vagrant up` pour construire la machine virtualbox.

Une fois la VM construite, la commande `vagrant ssh` permet de se connecter à la machine.

Le dossier vhosts est monté à l'emplacement `/etc/apache2/site-enabled`.
Le dossier www est monté à l'emplacement `/var/www`.
Le fichier `/etc/php5/apache2/php.ini` est modifié lors du provisionnement de la machine par le module `puppet/modules/php`.

Vous devez ajouter vos vhosts à votre fichier hosts sur votre machine hôte :
192.168.33.10 phpmyadmin.local.dev
192.168.33.10 project.local.dev
...

Vous pouvez gérer le service apache avec la commande suivante :
`sudo service apache start|stop|restart|reload|...`
