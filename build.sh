#!/bin/sh
cd simple-cdd
export simple_cdd_dir=`pwd`
build-simple-cdd --conf ./simple-cdd.conf --graphical-installer -p urna -a urna --locale pt_BR --keyboard br
