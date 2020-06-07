#!/bin/bash 
#$ -t 1-4
#$ -ckpt restart

f=$(ls a*.bam | head -n $SGE_TASK_ID | tail -n 1)
tmp1=tmp1_$f
header=${f%_*}_header.sam
out=lift_$f

module load samtools
#samtools view $f | python coordinate2genome.py > $tmp1
cat ../0genom/$header $tmp1 | samtools sort -T $SGE_TASK_ID > $out

samtools index $out 
