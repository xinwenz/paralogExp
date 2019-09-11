#!/bin/bash
#$ -pe openmp 16-64
#$ -ckpt restart

module load blast/2.8.1
blastn -db a4.fasta -query Dmel6_cdsFBgn.fasta -out dmel6cds_a4.blast -num_threads $NSLOTS -outfmt 10 

