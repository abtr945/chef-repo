#!/bin/sh

# run_test.sh - Wrapper program to run Post-conditions checking with timestamp of each run

# Command-line arguments: $1 - test number to run
                          $2 - number of nodes the cluster has
         
now=$(date +"%T")                 
echo "$now - running test_$1.rb"

sudo ruby /tmp/test_$1.rb $2
