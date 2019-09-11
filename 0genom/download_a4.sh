#!/bin/bash
#$ -N download_a4.sh

#position: ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/300/595/GCA_002300595.1_Dmel_A4_1.0
wget "ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/300/595/GCA_002300595.1_Dmel_A4_1.0/GCA_002300595.1_Dmel_A4_1.0_genomic.fna.gz" -O a4.fasta.gz
wget "ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/300/595/GCA_002300595.1_Dmel_A4_1.0/GCA_002300595.1_Dmel_A4_1.0_genomic.gbff.gz" -O a4.gbff.gz
wget "ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/300/595/GCA_002300595.1_Dmel_A4_1.0/GCA_002300595.1_Dmel_A4_1.0_genomic.gff.gz" -O a4.gff.gz
