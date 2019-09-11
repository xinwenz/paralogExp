#!/bin/bash
#$ -t 1-2
#$ -ckpt restart 

module load hisat2/2.1.0
module load samtools

t=$SGE_TASK_ID
ref=$(ls *.fasta | head -n $t | tail -n 1 )
index_nm=$(basename $ref .fasta)
hisat2-build $ref $index_nm 

case $t in
1) hisat2 -x a3_7 -U A3_fake.fastq.gz | samtools view -H > a3_header.sam;;
2) hisat2 -x a4_7 -U A4_fake.fastq.gz | samtools view -H > a4_header.sam;;
esac


