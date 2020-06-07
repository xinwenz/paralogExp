#!/bin/bash
#$ -ckpt restart 
#$ -t 1-3

n=$SGE_TASK_ID

module load samtools 

# chrosome name can't have colon; change all colon to _, and index bam file
case $n in
1) samtools view -h a3_nic.bam | sed -E 's/(a.*):([0-9]+\-[0-9]+):(FBgn[0-9]+):([0-9]+)/\1_\2_\3_\4/g' | samtools view -b > a3_nic_v2.bam
	samtools index a3_nic_v2.bam;;
2)samtools view -h a4_ctl.bam | sed -E 's/(a.*):([0-9]+\-[0-9]+):(FBgn[0-9]+):([0-9]+)/\1_\2_\3_\4/g' | samtools view -b > a4_ctl_v2.bam
	samtools index a4_ctl_v2.bam;;
3)samtools view -h a4_nic.bam | sed -E 's/(a.*):([0-9]+\-[0-9]+):(FBgn[0-9]+):([0-9]+)/\1_\2_\3_\4/g' | samtools view -b > a4_nic_v2.bam
	samtools index a4_nic_v2.bam;;
esac
