# Strict mode + ShellCheck

## set -e: stop when a command fails
If any command fails, the script stops right there.
Without it, Bash shows the error but keeps going, and the next
commands may depend on the one that failed.

## set -u: stop when a variable doesn't exist
If I use a variable that was never created (usually a typo like
$Pwd instead of $PWD), the script stops with an error.
Without it, the typo silently becomes empty and the script carries on.
(A variable I set to empty on purpose, like x="", is fine.)

## set -o pipefail: a pipe fails if ANY part fails
All commands in a pipe still run. Pipefail changes the RESULT:
- Without it: only the last command counts. `ls project? | sort`
  reports success (0) even though ls failed.
- With it: the pipe reports the failure (2).
Together with -e, the script then stops after that pipe.

## Always "$quote" variables
Without quotes, Bash splits a variable's value at every space.
"my file.txt" becomes two names: my and file.txt.
So `rm $file` can delete the wrong files. `rm "$file"` keeps
the name in one piece.

## ShellCheck
Checks a script for mistakes without running it.
Each warning has a code (like SC2086); look it up at
shellcheck.net/wiki/SC2086.
`# shellcheck disable=SC2086` on the line above silences that one
warning on that one line, for bugs I put there on purpose.
The output stays clean, so new real problems stand out.

## Rule for every script from now on
Start with `set -euo pipefail`, and it must pass ShellCheck.
