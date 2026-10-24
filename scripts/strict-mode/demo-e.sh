#!/usr/bin/env bash 

#When set -e was commented, the script kept running even after there was an error
#but when set -e was there, script stopped as soon as it got the error 

set -e
ls project?
echo "script kept going even after this error"
