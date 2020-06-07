#!/bin/bash
#$ -pe openmp 16-64
#$ -N hisat_map_nic
#$ -t 1-48 
#$ -ckpt restart 

sg=$SGE_TASK_ID
#sg=1

module load hisat2/2.1.0
module load samtools 

#hisat2 -x $sg/a3_pgene -U ../0express/A3_ctl.fastq.gz -p $NSLOTS -k 20 | samtools view -b -F 4 > $sg/a3_ctl.bam 
hisat2 -x $sg/a3_pgene -U ../0express/A3_nic.fastq.gz -p $NSLOTS -k 20 | samtools view -b -F 4 > $sg/a3_nic.bam 
#hisat2 -x $sg/a4_pgene -U ../0express/A4_ctl.fastq.gz -p $NSLOTS -k 20 | samtools view -b -F 4 > $sg/a4_ctl.bam 
hisat2 -x $sg/a4_pgene -U ../0express/A4_nic.fastq.gz -p $NSLOTS -k 20 | samtools view -b -F 4 > $sg/a4_nic.bam 
