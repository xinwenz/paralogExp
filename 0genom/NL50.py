#!/usr/bin/env python2 

import subprocess
import itertools
import sys

arg=r"bioawk -c fastx '{print length($seq)}' " + sys.argv[1]
#print arg		
p = subprocess.Popen(arg, shell=True,stdout=subprocess.PIPE)

n = []
for l in p.stdout:
	d=l.strip()
	n.append(int(d))


cum = 0
ht = int(sys.argv[2])/2.0
n1=sorted(n,reverse=True)
count = 0 

while True:
	cum += n1[count]
	#print cum
	if cum > ht:
		break
	count += 1 

print "GenomeSize", sys.argv[2]
print "largest fragment", n1[0]
print "number of fragments", len(n1)
print "NG50", n1[count]
print "L50", count+1
	

	#print(line2.strip())
		#print r1.readline().strip()
		#print r2.readline().strip()
		#print r2.readline().strip()
	

