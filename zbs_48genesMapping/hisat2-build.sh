#!/bin/bash
#$ -t 1-96

sg=$SGE_TASK_ID
module load hisat2/2.1.0
ref=$(ls */a*pgene.fasta | head -n $sg | tail -n 1)
index_nm=${ref%.fasta}

hisat2-build $ref $index_nm
