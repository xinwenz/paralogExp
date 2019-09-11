#!/bin/bash
#$ -N fastqc_all
#$ -t 1-4 

module load fastqc

f=$(ls A[34]*.fastq.gz | sort | head -n $SGE_TASK_ID | tail -n 1)
fastqc $f 


