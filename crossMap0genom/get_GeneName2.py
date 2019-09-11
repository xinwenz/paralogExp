# usage python get_geneName2.py a3_exon_cds.txt
# print list of paralog genes grpups and group number 

# logic: each candidata group in one list 

import sys
import re

prevType = 'CDS'
prevName = 'unknown'

infile = open(sys.argv[1],'r')
for l in infile:
	gtype = l.split('\t')[2]  # get gene type 
	gnote = l.split('\t')[8]  # get gene name 
	geneName_tmp = re.search("gene\=(.*?)\;",gnote)
	geneName = geneName_tmp.group(1) 
	
	iso_tmp = re.search("\s([A-Z])\;",gnote)
	iso = '' if iso_tmp == None else iso_tmp.group(1)

	gisoN = geneName + "_" + iso
	# in the border of cds and exon, or the geneName changes #### 
 	# each new exon's got name . 
	if  gtype=='exon' and ( prevType == 'CDS' or gisoN != prevName) :
		print gisoN
		prevName = gisoN	

	prevType = gtype

infile.close()


