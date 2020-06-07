module load bedtools
#bedtools getfasta -fi a3_6.fasta -bed pgene_a3.gff -fo a3_Pgene.fasta
#bedtools getfasta -fi a4_6.fasta -bed pgene_a4.gff -fo a4_Pgene.fasta

cut -f4 ../2blast0dmelref/a3_asRef/pgene_a3.bed > a3_name.list
cut -f4 ../2blast0dmelref/a4_asRef/pgene_a4.bed > a4_name.list

# combine name with fasta gene name 
awk '{printf $0; if (NR%2==1) {getline < "a3_name.list";print ":"$0} else{printf "\n"}}' a3_Pgene.fasta > a3_PgeneFB.fasta
awk '{printf $0; if (NR%2==1) {getline < "a4_name.list";print ":"$0} else{printf "\n"}}' a4_Pgene.fasta > a4_PgeneFB.fasta

rm *_name.list
rm a[34]_Pgene.fasta
