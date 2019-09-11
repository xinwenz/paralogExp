#!/bin/bash
#$ -pe openmp 16-64
#$ -ckpt restart

module load blast/2.8.1
blastn -db Dmel6_geneFBn.fasta -query ../0genom/a4_7.fasta -out a4_dmel6gen.blast -num_threads $NSLOTS -outfmt 10 

