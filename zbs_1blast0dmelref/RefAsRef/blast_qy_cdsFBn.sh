#!/bin/bash
#$ -pe openmp 16-64
#$ -ckpt restart

module load blast/2.8.1
blastn -db Dmel6_clean.fa -query Dmel6_cdsFBgn.fasta -out dmel6cds_ref.blast -num_threads $NSLOTS -outfmt 10 
