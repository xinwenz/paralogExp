# remove record only has a region labeled 
grep -P -v 'RefSeq\tregion' Dmel6.gff > Dmel6_clean.gff

# generate the chromosome list , 57 left 
bioawk -c gff '{print $1}' Dmel6_clean.gff | uniq > chrom_list

# original .fa has newline in the sequence, remove them 
bioawk -c fastx '{print ">"$name; print $seq}' Dmel6.fa > Dmel6_nonewline.fa

# only take chromosome from chromsome list 
cat chrom_list | while read p ; do grep -A1 $p Dmel6_nonewline.fa ; done > Dmel6_clean.fa
