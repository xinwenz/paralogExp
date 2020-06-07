#!/bin/bash
#$ -N augustus_all
#$ -t 1-2
#$ -ckpt restart

module load augustus/3.2.1

f=$(ls *.fasta | head -n $SGE_TASK_ID | tail -n 1 )
augustus --species=fly $f
