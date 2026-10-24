#!/usr/bin/env bash
#
# demo-pipefail.sh: shows what "set -o pipefail" catches
#
# Test:    ls project? | sort   (ls fails, sort succeeds)
#
# Without pipefail: exit code 0
#   Only the LAST command in a pipe counts. sort succeeded,
#   so the whole pipe reported success and hid the ls failure.
#
# With pipefail: exit code 2
#   The pipe fails if ANY command in it fails. 2 is ls's own
#   exit code for "cannot access".
#
# Lesson: without pipefail, a broken first step in a pipe
#         can look like success.
