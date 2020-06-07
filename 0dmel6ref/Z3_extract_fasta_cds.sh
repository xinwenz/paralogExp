grep -P '\tCDS\t' Dmel6_clean.gff > Dmel6_cds.gff

# remove duplicate CDS of different splice.
awk '!seen[$1$4$5$7]++' Dmel6_cds.gff > Dmel6_cds_nodup.gff

# get gene fly base name from gff file 
awk 'match($0,/FLYBASE:FBgn[0-9]*/) {printf NR; printf "|" ; printf substr($0,RSTART+8,RLENGTH-8); printf "|"; printf $4; printf "|";print $5-$4 + 1}' Dmel6_cds_nodup.gff > Dmel6_cds_ele.txt

module load bedtools
# stand info retain 
# extract fasta from gff file  
bedtools getfasta -s -fi Dmel6_clean.fa -bed Dmel6_cds_nodup.gff -fo Dmel6_cds.fasta

# combine name with fasta title
awk '{printf $0; if (NR%2==1) {getline < "Dmel6_cds_ele.txt";print ":"$0} else{printf "\n"}}' Dmel6_cds.fasta > Dmel6_cdsFBgn.fasta

#rm Dmel6_cds.fasta
