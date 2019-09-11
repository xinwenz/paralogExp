#!/bin/bash
#$ -t 1-4 
#$ -N gzip_all

f=$(ls *.fastq | sort | head -n $SGE_TASK_ID | tail -n 1)

gzip $f  
