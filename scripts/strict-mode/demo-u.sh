#!/usr/bin/env bash

#with set -u commented, I see the script with error still runs and was no able to print the value of variable.
#when set -u was used, it  gave error in the script which says Pwd is unbound variable

set -u

# shellcheck disable=SC2154  # intentional: ls is used only to fail
saved=$Pwd

echo "the current directory is $saved"
