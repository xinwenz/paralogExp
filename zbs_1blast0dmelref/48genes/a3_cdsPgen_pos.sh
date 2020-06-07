#!/bin/bash 
#$ -t 1-48 

fbname=$(head -n $SGE_TASK_ID 48gene.list | tail -n 1) 
midfile=a3_${fbname}.tmp
outfile=a3_${fbname}.df
grep $fbname ../a3AsRef/dmel6cds_a3.blast ../a3AsRef/dmel6Pgen_a3.blast > $midfile

python -<< EOF $midfile > $outfile
import sys
import re
f = open(sys.argv[1],'r')
for l in f:
	ele = l.rstrip().split(":")
	all = ele[3].split(",")
#	print(all)
	map_chrom = all[1]
	map_idt = float(all[2])
	map_legh = int(all[3])
	
	if "cds" in ele[0]:
		cds_real_legh = int(all[0].split("|")[-1])
		if map_legh > 0.95 * cds_real_legh and map_idt > 95:
			print(map_chrom,all[8],all[9], map_idt, map_legh/cds_real_legh, sep="\t")
	
	elif 'Pgen' in ele[0]:
		tmp = re.findall(r'\d+',ele[2]) 
		pg_real_legh = abs(int(tmp[0]) - int(tmp[1]) ) 
		if map_legh > 0.5 * pg_real_legh: 
			print(map_chrom, all[8],all[9],map_idt, map_legh/pg_real_legh, sep="\t")
		
	else:
		raise ValueError

f.close()
EOF

