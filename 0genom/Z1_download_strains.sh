#!/bin/bash
#$ -t 1-11

list_addr=(
""
"b3 male ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/003/402/055/GCA_003402055.1_ASM340205v1/GCA_003402055.1_ASM340205v1_genomic.fna.gz"
"a1 male ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/003/401/735/GCA_003401735.1_ASM340173v1/GCA_003401735.1_ASM340173v1_genomic.fna.gz"
"b1 male ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/003/401/925/GCA_003401925.1_ASM340192v1/GCA_003401925.1_ASM340192v1_genomic.fna.gz"
"a6 male ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/003/401/885/GCA_003401885.1_ASM340188v1/GCA_003401885.1_ASM340188v1_genomic.fna.gz"
"a7 male ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/003/401/915/GCA_003401915.1_ASM340191v1/GCA_003401915.1_ASM340191v1_genomic.fna.gz"
"ab8 male ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/003/401/685/GCA_003401685.1_ASM340168v1/GCA_003401685.1_ASM340168v1_genomic.fna.gz"
"a2 male ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/003/401/805/GCA_003401805.1_ASM340180v1/GCA_003401805.1_ASM340180v1_genomic.fna.gz"
"a5 male ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/003/401/855/GCA_003401855.1_ASM340185v1/GCA_003401855.1_ASM340185v1_genomic.fna.gz"
"b4 male ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/003/402/005/GCA_003402005.1_ASM340200v1/GCA_003402005.1_ASM340200v1_genomic.fna.gz"
"b2 male ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/003/401/975/GCA_003401975.1_ASM340197v1/GCA_003401975.1_ASM340197v1_genomic.fna.gz"
"b6 male ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/003/397/115/GCA_003397115.2_ASM339711v2/GCA_003397115.2_ASM339711v2_genomic.fna.gz"
)

n=$SGE_TASK_ID
folder=$(echo ${list_addr[$n]} | cut -d" " -f1)
addr=$(echo ${list_addr[$n]} | cut -d" " -f3)
output=$folder.fasta.gz

#echo $addr
mkdir $folder
wget $addr -O $folder/$output

