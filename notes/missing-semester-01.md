# Missing Semester · Lecture 1: The shell

## Key ideas
- `./file` runs a file in the current folder
- Permission bits in `ls -l`: owner / group / others, each with r w x
- `chmod u+x file` lets the owner run a file
- `|` sends one command's output into the next
- `>` saves output to a file (overwrites); `>>` adds to the end
- `grep -i word` keeps only the lines containing a word, ignoring case
- 

## Exercise I built
`./semester | grep -i last-modified > ~/last-modified.txt`
Runs the script, keeps only the last-modified line and saves it to a file in my home folder.

