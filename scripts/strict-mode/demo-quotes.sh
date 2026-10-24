#!/usr/bin/env bash
#
# demo-quotes.sh: shows why variables need double quotes
#
# Setup:   /tmp/quote-test with three files: "my file.txt", "my", "file.txt"
#          saved="my file.txt"
#
# Without quotes: rm $saved
#   Bash splits the text at the space (word splitting), so rm gets
#   two names: "my" and "file.txt". It deletes those two, the WRONG
#   files, and leaves "my file.txt".
#
# With quotes: rm "$saved"
#   The quotes keep the text as one word, so rm gets one name and
#   deletes only "my file.txt". The other two survive.
#
# Lesson: always quote variables ("$var"). An unquoted variable with
#         a space can make a command act on the wrong files.
#         ShellCheck warns about this as SC2086.

set -e 

mkdir -p /tmp/quote-test

cd /tmp/quote-test 

touch 'my file.txt' && touch my file.txt

saved="my file.txt"

# shellcheck disable=SC2086  # intentional: ls is used only to fail
rm $saved

echo "remove without quotes" 

ls

touch 'my file.txt' && touch my file.txt

rm "$saved"

echo "remove with quotes"

ls

