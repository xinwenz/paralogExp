#!/bin/bash
#$ -t 1-11

ls=("" a1 a2 a5 a6 a7 ab8 b1 b2 b3 b4 b6)
flder=${ls[$SGE_TASK_ID]}

cd ${flder}_asRef

blastfl=dmel6cds_${flder}.blast
outfl=${flder}_cds.suz

python -<<EOF $blastfl > $outfl
import sys

f=open(sys.argv[1],'r')

def conv_dic(x) :
	sorted_x = sorted(x.items(), key = lambda kv: kv[1][0] , reverse=True)
	lth=[]
	hits=[]
	for i in sorted_x:
		lth.append(i[1][0])
		hits.append(i[1][1])
	if len(lth)>5:
		return lth[0:5] + hits[0:5]
	else:
		return lth + ["na"] * (5-len(lth)) + hits + ["na"] * (5-len(hits))


mydic = {}
for l in f:
	ele = l.rstrip().split(',')
	ele0 = ele[0].split(":")
	
	chrom = ele0[0]
	posit = int(ele0[1].split("-")[0])
	
	name_tags = ele0[2].split('|')
	cds_label = name_tags[0]
	gene_name = name_tags[1]
	cds_length = int(name_tags[3])
	
	ident = float(ele[2])
	lth = int(ele[3])
	
	if ident > 95 and lth > 0.95 * cds_length: 
		if gene_name not in mydic.keys():
			mydic[gene_name] = [chrom,posit,{}]
			mydic[gene_name][2][cds_label] = [cds_length,1]	
		else:
			if cds_label not in mydic[gene_name][2].keys():
				mydic[gene_name][2][cds_label] = [cds_length,1]
			else:
				mydic[gene_name][2][cds_label][1] += 1 
	else:
		pass
		

f.close()

for key in mydic:
	tmp = mydic[key]
	print(key,tmp[0],tmp[1],*conv_dic(tmp[2]),end='')
	print()

EOF
