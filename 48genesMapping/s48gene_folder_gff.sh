#!/bin/bash 
#$ -t 1-48
sg=$SGE_TASK_ID
#sg=1
gNu=$(head -n $sg 48gene_order.list | tail -n 1 | cut -f1)
gene=$(head -n $sg 48gene_order.list | tail -n 1 | cut -f2)

mkdir $gNu
midfile=${gene}.tmp
outfile=${gNu}/${gene}.gff

grep $gene ../1blast0dmelref/a3AsRef/dmel6Pgen_a3.blast ../1blast0dmelref/a4AsRef/dmel6Pgen_a4.blast > $midfile

python -<< AEND $midfile  > $outfile
import sys
import re
f = open(sys.argv[1],'r')

mydic = {} 
for l in f:
	#print(l)
	ele = l.split(":")
	tmp = ele[3].split(",")
	#print(tmp)
	geneNm = tmp[0]
	tmp2 = re.findall(r'\d+', ele[2])
	#print(tmp2)
	lth_iso = abs( int(tmp2[0]) - int(tmp2[1]))
	#print("---")
	#print(tmp[3])
	lth_mapped = int(tmp[3])
	#print(lth_mapped)
	if lth_mapped > 0.5 * lth_iso:
		if geneNm not in mydic.keys():
			mydic[geneNm] = 1 
		else:
			mydic[geneNm] += 1 
		
		chrom_map = tmp[1]
		strd = "+" if int(tmp[8]) <= int(tmp[9]) else "-"
		start_gff = min( int(tmp[8]), int(tmp[9]))
		end_gff = max( int(tmp[8]), int(tmp[9]) )
		
		geneNm2 = geneNm + ":" + str(mydic[geneNm])
		
		print(chrom_map, "XZ", 'Pgene', start_gff, end_gff, '.', strd, '.', "Name="+geneNm2, sep="\t")	
f.close()
AEND
