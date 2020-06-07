grep -P '\tgene\t.*protein_coding.*' Dmel6_clean.gff > Dmel6_clean_Pgene.gff

# get gene fly base name from gff file 
awk 'match($0,/FLYBASE:FBgn[0-9]*/) {print substr($0,RSTART+8,RLENGTH-8)}' Dmel6_clean_Pgene.gff > Dmel6_Pgene_list

module load bedtools
# stand info retain 
# extract fasta from gff file  
bedtools getfasta -s -fi Dmel6_clean.fa -bed Dmel6_clean_Pgene.gff -fo Dmel6_Pgene.fasta

# combine name with fasta title
awk '{printf $0; if (NR%2==1) {getline < "Dmel6_Pgene_list";print ":"$0} else{printf "\n"}}' Dmel6_Pgene.fasta > Dmel6_PgeneFBn.fasta

rm Dmel6_Pgene.fasta
rm Dmel6_Pgene_list

