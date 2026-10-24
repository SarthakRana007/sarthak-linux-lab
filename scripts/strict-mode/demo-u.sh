#!/usr/bin/env bash

#with set -u commented, I see the script with error still runs and was no able to print the value of variable.
#when set -u was used, it  gave error in the script which says Pwd is unbound variable

set -u
saved=$Pwd

echo "the current directory is $savEd"
