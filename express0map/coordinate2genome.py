import sys
for line in sys.stdin:
	ele = line.split('\t')
	segname = ele[0]
	flag = ele[1]
	refName = ele[2]
	if refName == '*':
		continue
	else:
		tmp = refName.split(':')
		chrom = tmp[0]
		chrom_start = int(tmp[1].split('-')[0])
		mapp_start = int(ele[3])
		lift_start = chrom_start + mapp_start
		print(segname, flag, chrom, lift_start, ele[4],ele[5],ele[6],ele[7],ele[8],ele[9],ele[10],sep='\t')
