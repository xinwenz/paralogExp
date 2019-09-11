# usage python get_paraGene.py tmp_sort_gene_id.txt 
# print list of paralog genes grpups and group number 

# logic: each candidata group in one list 

import sys
import re

prev = 'firs'
infile = open(sys.argv[1],'r')

ans=[[]]
for l in infile:
	g = l.split('=')[1].split(';')[0]  # get gene name 
	firstfew_tmp = re.search('^\D*',g)
	firstfew = firstfew_tmp.group(0) 
	if firstfew != prev:
		if len(ans[-1]) <= 1: 
			ans.pop()
		ans.append([])
		ans[-1].append(g) 
	else:
		ans[-1].append(g)
	
	prev = firstfew

infile.close()

ans_len = len(ans)
for i in range(ans_len):
	if len(ans[i]) < 20:	
		print i,ans[i]



