#!/bin/bash
#$ -ckpt restart
#$ -pe openmp 16-64
#$ -t 1-4 

n=$SGE_TASK_ID

module load hisat2/2.1.0
module load samtools

case $n in 
1) hisat2 -x a3_PgeneFB -U ../0express/A3_ctl.fastq.gz -p $NSLOTS -k 20 | samtools sort -T $n> a3_ctl.bam;;
2) hisat2 -x a3_PgeneFB -U ../0express/A3_nic.fastq.gz -p $NSLOTS -k 20 | samtools sort -T $n> a3_nic.bam;;
3) hisat2 -x a4_PgeneFB -U ../0express/A4_ctl.fastq.gz -p $NSLOTS -k 20 | samtools sort -T $n> a4_ctl.bam;;
4) hisat2 -x a4_PgeneFB -U ../0express/A4_nic.fastq.gz -p $NSLOTS -k 20 | samtools sort -T $n> a4_nic.bam;;
esac
