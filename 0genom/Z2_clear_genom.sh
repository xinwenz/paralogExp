#!/bin/bash
#$ -t 1-11

ls=("" a1 a2 a5 a6 a7 ab8 b1 b2 b3 b4 b6)
flder=${ls[$SGE_TASK_ID]}
out=${flder}_6.fasta.gz
bioawk -c fastx '{if (NR <= 6) {print $seq}}' $flder/${flder}.fasta.gz >$flder/tmp.fasta
python -<< AAA $flder/tmp.fasta $flder | gzip > $flder/$out
import sys
import os
file = open(sys.argv[1], 'r')
lines = file.readlines()
prfx = sys.argv[2]
nms = ["X", "2L","2R","3L", "3R","4"]
for i in range(len(nms)):
  print(">"  + prfx + "." + nms[i])
  print(lines[i],end="") # each item has an hided newline
file.close()
os.remove(prfx + "/tmp.fasta")
AAA
