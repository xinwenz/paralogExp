#!/bin/bash
#! -ckpt restart

#blastfl=dmel6cds_a3.blast
#outfl=suz_cdsInGene.res

#python -<<EOF $blastfl > $outfl
import sys

f1 = open(sys.argv[1],'r') # struct_list.bed2 
f2 = open(sys.argv[2],'r') # a3 cds blast file
f3 = open(sys.argv[3],'r') # a4 cds blast file

def addoverlap(x,w): # use x file, add to w in list. 
	for l in x:
		ele = l.rstrip().split(',')
		ele0 = ele[0].split(":")
	
		name_tags = ele0[2].split('|')
		cds_label = name_tags[0]
		gene_name = name_tags[1]
		cds_length = int(name_tags[3])
	
		ident = float(ele[2])
		lth = int(ele[3])

		tar_chr = ele[1]
		tar_stt = ele[8]
		tar_end = ele[9]
	
		if ident > 95 and lth > 0.95 * cds_length: 
			if gene_name in mydic.keys():
				if cds_label not in mydic[gene_name][w].keys():
					mydic[gene_name][w][cds_label] = [[tar_chr,tar_stt,tar_end]]
				else:
					mydic[gene_name][w][cds_label] += [[tar_chr,tar_stt,tar_end]] 
		else:
			pass

def dic_range(x) :
	if len(x)==0:
		print()
		return 
	sorted_x = sorted(x.items(),key= lambda kv: kv[0], reverse=True)
	infor = sorted_x[0][1] 
	ndup = len(infor)
	
	for i in range(ndup): 
		chrom = infor[i][0]
		start = max(int(infor[i][1]) - 36000,0)
		end = int(infor[i][2]) + 36000
		print(chrom,start,end,".",sep="\t")
		

# build a dictionary with interested genes 
mydic = {}
for l in f1:
	ele = l.rstrip().split("\t")
	geneName = ele[3]
	chrom = ele[0]
	start = int(ele[1])
	end = int(ele[2])
	if geneName not in mydic.keys():
		mydic[geneName] = [chrom,start,end,{},{}]
	else:
		pass


addoverlap(f2,3)
addoverlap(f3,4)
		

f1.close()
f2.close()
f3.close()

for key in mydic:
	tmp = mydic[key]
	print(tmp[0],tmp[1],tmp[2],key)
	dic_range(tmp[3])
	dic_range(tmp[4])

#EOF

#print(mydic)
