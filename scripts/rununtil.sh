#!/usr/bin/env bash
>out.txt
>err.txt

count=0 
while ./buggy.sh >> out.txt 2>> err.txt; do
	count=$((count+1))

done
echo "It failed after $((count +1)) runs"
cat out.txt
cat err.txt
