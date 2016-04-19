#!/bin/sh
if [ ! -f root/opt/VBoxLinuxAdditions.run ] 
then
   echo "Copie o VBoxLinuxAdditions.run para root/opt antes de continuar..."
   exit 1
fi
cd root
tar -czf urna_extras.tar.gz *
mv urna_extras.tar.gz ../simple-cdd/profiles
cd ../simple-cdd
export simple_cdd_dir=`pwd`
build-simple-cdd --conf ./simple-cdd.conf --graphical-installer -p urna -a urna --locale pt_BR --keyboard br-abnt2 
