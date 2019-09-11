#!/bin/bash
#$ -ckpt restart 

blastfl=dmel6Pgen_ref.blast
outbed=fz_dmel6Pgen_ref.bed
outgff=fz_dmel6Pgen_ref.gff
outsuz=fz_dmel6Pgen_ref_suz.list

python -<< EOF $blastfl $outbed $outgff $outsuz
import sys
import re
f = open(sys.argv[1],'r')
f2= open(sys.argv[2],'w')
f3= open(sys.argv[3],'w')
f4= open(sys.argv[4],'w')

mydic={}
for l in f:
	ele = l.rstrip().split(',')
	ele0 = ele[0].split(":")
	geneNm = ele0[2]
	tmp = re.findall(r'\d+', ele0[1])
	lth_iso = abs( int(tmp[0]) - int(tmp[1]) )
	
	lth_mapped = int(ele[3])
	if lth_mapped > 0.50 * lth_iso:
		if geneNm not in mydic.keys():
			mydic[geneNm] = 1 
		else: 
			mydic[geneNm] += 1

		chrom_map = ele[1]
		start_map = max( min( int(ele[8]) , int(ele[9])) -1000  - 1 , 0 )  
		strd = "+" if int(ele[8]) <= int(ele[9]) else "-"
		
		start_gff = min( int(ele[8]) , int(ele[9]))
		start_bed = max( start_gff - 1000  - 1 , 0 )

		end_gff =  max( int(ele[8]) , int(ele[9]) )

		if chrom_map == "a4.mitoch":
			end_bed = min( end_gff + 1000 , 18338)
		elif chrom_map == "a4.2R":
			end_bed = min( end_gff + 1000 , 25479258)
		else:
			end_bed =  end_gff + 1000

		geneNm2 = geneNm + ':' + str(mydic[geneNm])
		print(chrom_map, start_bed, end_bed, geneNm2,sep="\t", file=f2)
		print(chrom_map, "XZ", 'Pgene',start_gff, end_gff, '.', strd, '.', 'Name='+geneNm2, sep="\t",file=f3)

f.close()
f2.close()
f3.close()

for i in mydic:
	print(i ,mydic[i],sep="\t",file=f4)
f4.close()
EOF
