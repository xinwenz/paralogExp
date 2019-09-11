# input struct_list
# out put it's postion in gff gene file 

while read p; do grep $p Dmel6_clean_gene.gff ; done < struct_list | cut -f1,4,5 > struct_list.bed
paste struct_list.bed struct_list > struct_list.bed2
rm struct_list.bed
