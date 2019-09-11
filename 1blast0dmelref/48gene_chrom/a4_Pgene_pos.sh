#!/bin/bash 
#$ -t 1-48 

fbname=$(head -n $SGE_TASK_ID 48gene.list | tail -n 1) 
midfile=a4_${fbname}.tmp
outfile=a4_${fbname}.df
grep $fbname ../a4AsRef/dmel6Pgen_a4.blast > $midfile

python -<< AAA $midfile > $outfile
import sys
import re
f = open(sys.argv[1],'r')
for l in f:
#	print(l)
	ele = l.rstrip().split(":")
	all = ele[2].split(",")
#	print(all)
	map_chrom = all[1]
	map_idt = float(all[2])
	map_legh = int(all[3])
	
#	if "cds" in ele[0]:
#		cds_real_legh = int(all[0].split("|")[-1])
#		if map_legh > 0.95 * cds_real_legh and map_idt > 95:
#			print(map_chrom,all[8],all[9], map_idt, map_legh/cds_real_legh, sep="\t")
#	
#	elif 'Pgen' in ele[0]:
	tmp = re.findall(r'\d+',ele[1]) 
	pg_real_legh = abs(int(tmp[0]) - int(tmp[1]) ) 
	if map_legh > 0.5 * pg_real_legh: 
		print(map_chrom, all[8],all[9],map_idt, map_legh/pg_real_legh, sep="\t")
		
#	else:
#		raise ValueError

f.close()
AAA

