#!/bin/bash
#$ -t 1-11

ls=("" a1 a2 a5 a6 a7 ab8 b1 b2 b3 b4 b6)
flder=${ls[$SGE_TASK_ID]}

cd ${flder}_asRef

module load blast/2.8.1
blastn -db ${flder}_6 -query Dmel6_cdsFBgn.fasta -out dmel6cds_${flder}.blast -num_threads $NSLOTS -outfmt 10 
