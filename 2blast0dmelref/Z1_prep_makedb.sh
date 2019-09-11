#!/bin/bash
#$ -t 1-11

ls=("" a1 a2 a5 a6 a7 ab8 b1 b2 b3 b4 b6)
flder=${ls[$SGE_TASK_ID]}

mkdir ${flder}_asRef
cd ${flder}_asRef
ln -s /dfs3/jje-lab/xinwenz/paralogExp/0genom/$flder/${flder}_6.fasta.gz ${flder}_6.fasta.gz
ln -s /dfs3/jje-lab/xinwenz/paralogExp/0dmel6ref/Dmel6_cdsFBgn.fasta Dmel6_cdsFBgn.fasta
ln -s /dfs3/jje-lab/xinwenz/paralogExp/0dmel6ref/Dmel6_PgeneFBn.fasta Dmel6_PgeneFBn.fasta

module load blast/2.8.1

gunzip -c ${flder}_6.fasta.gz | makeblastdb -in - -dbtype nucl -parse_seqids -out ${flder}_6 -title ${flder}
