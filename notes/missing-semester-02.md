# Missing Semester · Lecture 2: Shell tools and scripting

## Key ideas
- Variables: `foo=bar` (no spaces). `"$foo"` uses the value; `'$foo'` is just the text $foo
- Special variables: `$1` first argument, `$@` all arguments, `$#` number of arguments, `$?` exit code of the last command
- Exit codes: `0` = success, anything else = failure
- `&&` runs the next command only on success, `||` only on failure
- `$(command)` puts a command's output in place (command substitution)
- `<(command)` turns a command's output into a pretend file (process substitution)
- Globs: `*` any characters, `?` exactly one character, `{a,b}` expands to both (`touch file{1,2}`)
- Shebang: `#!/usr/bin/env bash` on the first line says which program runs the script
- Functions run in your current shell (so `cd` works); scripts run in a new one
- `find . -name '*.txt' -type f` finds files by name
- `grep -R word folder` searches inside files
- `Ctrl+R` searches your command history
- ShellCheck catches mistakes in scripts

## Exercises

### marco / polo (functions)
- A function: `name() { commands; }`
- `$PWD` holds the current folder (uppercase; `$pwd` is empty)
- `$var` uses a variable's value; `"$var"` in quotes keeps spaces safe
- Load functions with `source file.sh`, not `./file.sh` (that runs in a separate shell, so everything is lost)

### Run until it fails
- No spaces around `=`: `count=0`, not `count = 0`
- `$(( count + 1 ))` does maths
- `while command; do ... done` repeats as long as the command succeeds (exit code 0)
- `>> file` appends normal output, `2>> file` appends error output
- `> file` on its own empties a file
- The loop body skips the failing run, so the total is count + 1

### find + xargs (zip all HTML files)
- `find . -name "*.html" -type f | xargs -d '\n' zip html.zip`
- xargs turns lines of text into arguments; zip needs arguments, not piped text
- By default xargs splits on spaces, so `-d '\n'` makes it split only on new lines
- Safer: `find ... -print0 | xargs -0 ...`
