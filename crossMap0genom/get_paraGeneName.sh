bioawk -c gff '{if($3=="exon" || $3 == "CDS" ) print $0}' a3dmel6/a3_7.gff > a3_exon_cds.gff
bioawk -c gff '{if($3=="exon" || $3 == "CDS" ) print $0}' a4dmel6/a4_7.gff > a4_exon_cds.gff
bioawk -c gff '{if($3=="exon" || $3 == "CDS" ) print $0}' a4dmel6/dmel6.gff > dmel6_exon_cds.gff

#grep -P -o  'FlyBase\|.*?\|' a3_mRNA.gff | sort | uniq -c > a3_uniq_gene_name.txt
#python get_paraGenes.py a3_uniq_gene_name.txt > a3_group_gene.txt

#grep -P -o 'gene\=.{1,15}\;' a4_mRNA.gff | sort | uniq -c > a4_uniq_gene_name.txt
#grep -P -o  'FlyBase\|.*?\|' a4_mRNA.gff | sort | uniq -c > a4_uniq_gene_name.txt

#python get_paraGenes.py a4_uniq_gene_name.txt > a4_group_gene.txt

#rm a3_uniq_gene_name.txt
#rm a4_uniq_gene_name.txt
