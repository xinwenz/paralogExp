#!/bin/bash 
#$ -t 1-4 
#$ -ckpt restart 

f=$(ls *.bam | head -n $SGE_TASK_ID | tail -n 1) 
module load samtools
samtools index $f 

