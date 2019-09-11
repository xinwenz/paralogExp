#!/bin/bash
#$ -t 1-11

cat file_seq.txt > file.tmp
python -<< AAA file.tmp "b3" | grep ">"
import sys
import os
file = open(sys.argv[1], 'r')
lines = file.readlines()
prfx = sys.argv[2]
nms = ["X", "2L","2R"]
for i in range(len(nms)):
  print(">"+prfx+".",  end="")
  print(nms[i])
  print(lines[i],end="")
file.close()
os.remove("file.tmp")
AAA
