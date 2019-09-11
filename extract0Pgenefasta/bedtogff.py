# from bed file to gff file 
# add strand info 
import sys
f=open(sys.argv[1],'r')
for l in f:
	ele = l.rstrip().split('\t')
	chrom = ele[0]
	start = int(ele[1]) + 1 
	end = ele[2]
	gname = ele[3]
	strd = ele[4]
	print(chrom,"xz",'Pgene',start,end,".",strd,'.','gene_id '+gname, sep='\t')
f.close()
