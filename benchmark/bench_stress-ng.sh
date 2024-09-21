#!/bin/bash
TEST=(af-alg pipe fork mmap)

for t in "${TEST[@]}"; do
  for i in $(seq 4); do
    stress-ng --taskset 0-1  --metrics-brief -t 30s --"$t" 2
  done
done
