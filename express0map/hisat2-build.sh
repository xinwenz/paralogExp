#!/bin/bash
#$ -t 1-2 
#$ -ckpt restart

module load hisat2/2.1.0
ref=$(ls *.fasta | head -n $SGE_TASK_ID | tail -n 1) 
index_nm=$(basename $ref .fasta)
hisat2-build $ref $index_nm

