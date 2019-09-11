fbam=a3_ctl.bam
fsam=${fbam%.bam}.sam
out=${fbam%.bam}.sam_lab

module load samtools  
samtools view $fbam > $fsam 

python3 -<< AAA $fsam > $out
# python 
# input file test_ctl.sam 
# perfect matching two conditions: 1) cigar no other than ; MSN 2) MD must be all numbers 

import sys 
import re

f = open(sys.argv[1])
mydic = {}
for l in f:
	ele = l.rstrip().split('\t')
	read_name = ele[0]
	posit = ele[2]
	start = ele[3]
	cigar = ele[5]
	md_tmp = re.findall("MD:Z:\w+", " ".join(ele[11:])) 
	md = md_tmp[0].split(":")[2]
	print(read_name, posit,start,cigar,md)
#	if 'D' not in cigar and 'I' not in cigar and 'P' not in cigar and 'X' not in cigar and md.isdigit():
#		if posit not in mydic: 
#			mydic[posit] = [read_name]
#		else:
#			mydic[posit].append(read_name)	
f.close()

#set_num = len(mydic)

#comm_set = set(list(mydic.values())[0])
#for key in mydic:
#	comm_set = comm_set & set(mydic[key])

#print("common reads:" , len(comm_set), comm_set)
#print("common reads:", len(comm_set))
#for key in mydic:
	#uniq_set = set(mydic[key]) - comm_set
	#print("uniq reads:", key , len(uniq_set) , uniq_set)
	#print("uniq reads", key, len(uniq_set))

AAA
