#!/bin/bash 
#$ -t 1-48 

sg=$SGE_TASK_ID

#module load bedtools
#bedtools getfasta -fi a34.fasta -bed $sg/*.gff -fo $sg/pgene.fasta

sn=$(grep -n '>a4' $sg/pgene.fasta | head -n 1 | cut -d":" -f 1)
s1=$(echo $sn -1 | bc)
sall=$(wc -l $sg/pgene.fasta | cut -d" " -f1)
s2=$(echo $sall - $s1 | bc)

head -n $s1 $sg/pgene.fasta > $sg/a3_pgene.fasta
tail -n $s2 $sg/pgene.fasta > $sg/a4_pgene.fasta
