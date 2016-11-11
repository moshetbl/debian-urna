#!/bin/sh
export udebs_folder=`pwd`/udebs
cd simple-cdd
export simple_cdd_dir=`pwd`
build-simple-cdd --local-packages $udebs_folder --conf ./simple-cdd.conf --graphical-installer -p urna -a urna --locale pt_BR --keyboard br
